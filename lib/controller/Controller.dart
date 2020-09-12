import 'dart:io';
import 'package:MC/model/Persistence/DeserializeCache.dart';
import 'package:MC/model/Persistence/DeserializeOffline.dart';
import 'package:MC/model/Persistence/SerializeCache.dart';
import 'package:MC/model/Persistence/SerializeOffline.dart';
import 'package:MC/model/Persistence/StoreManager.dart';
import 'package:MC/model/UnitCache.dart';
import 'package:MC/model/Web/HttpRequest.dart';
import 'package:MC/model/web/HtmlParser.dart';
import 'package:MC/model/LeafInfo.dart';
import 'package:MC/model/Cache.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:MC/utility/Style.dart';

class Controller {
  Cache _cache;
  List<NodeInfo> _events;
  List<NodeInfo> _promos;
  static const FNCACHE = 'cache.json';
  static const FNOFFLINE = 'offline.json';

  Controller() {
    _events = [];
    _promos = [];
    _cache = new Cache();
    initOffline();
  }

  Future<bool> tryConnection() async {
    final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  }

  Future<dynamic> initLoadAndStore() async {
    if (this._cache.lastLeafs == null) {
      try {
        await tryConnection();
        try {
          await _loadCache();
        } catch (e) {
          try {
            await _loadStaticLastInfo(4, 4);
          } catch (e) {}
        }
        _storeCache();
        _storeOffline();
      } catch (e) {
        Cache tmpCache =
            DeserializeCache.deserialize(await StoreManager.load(FNCACHE));
        this._cache.search = tmpCache.search;
        this._cache.lastSearch = tmpCache.lastSearch;
        this._cache.leafs = tmpCache.leafs;
        this._cache.lastLeafs = tmpCache.lastLeafs;
      }
    }
    return this._cache.lastLeafs;
  }

  Future<dynamic> _loadStaticLastInfo(int countNodes, int countLeafs) async {
    await initOrganizations();
    if (countNodes > this.getOrganizations().length)
      countNodes = this.getOrganizations().length;
    for (int i = countNodes - 1; i >= 0; i--) {
      NodeInfo node = this.getOrganizations()[i];
      this._cache.search['Empty $i'] = UnitCache(
          null, DateTime.now().subtract(Duration(days: 5)), 'Name', null);
      await setSearch(node.name, node.url, null);
      this._cache.search[node.url] =
          UnitCache(this.getSearch(), DateTime.now(), node.name, IconComune);
    }
    if (countLeafs > this.getSearch().length)
      countNodes = this.getSearch().length;
    for (int i = 0; i < countLeafs; i++) {
      NodeInfo node = this.getSearch()[i];
      this._cache.leafs['Empty $i'] = UnitCache(
          null, DateTime.now().subtract(Duration(days: 5)), 'Name', null);
      await setLeafInfo(node.name, node.url, null);
      this._cache.leafs[node.url] = UnitCache(
          this.getLeafs(), DateTime.now(), node.name, findImage(node.name));
    }
    return this._cache.lastLeafs;
  }

  Future<dynamic> initCategories() async {
    if (this.getCategories().isEmpty) {
      try {
        this._cache.initCategories(await HtmlParser.categories());
      } catch (e) {
        Cache tmpCache =
            DeserializeCache.deserialize(await StoreManager.load(FNCACHE));
        this._cache.initCategories(tmpCache.categories);
      }
    }
    return this.getCategories();
  }

  Future<dynamic> initOrganizations() async {
    if (this.getOrganizations().isEmpty) {
      try {
        this._cache.initOrganizations((await HtmlParser.organizations())
            .where((element) =>
                int.parse(element.description.replaceAll(' Dataset', '')) > 0)
            .toList());
      } catch (e) {
        Cache tmpCache =
            DeserializeCache.deserialize(await StoreManager.load(FNCACHE));
        this._cache.initOrganizations(tmpCache.organizations);
      }
    }
    return this.getOrganizations();
  }

  Future<dynamic> initOffline() async {
    try {
      for (var el in this._cache.offline) {
        List<LeafInfo> list = await HtmlParser.leafsByWord(el.sourceUrl);
        el = list[el.sourceIndex];
      }
    } catch (e) {}
    _loadOffline();
    return getOffline();
  }

  Future<dynamic> initEvents() async {
    if (this._events.isEmpty) this._events = await HtmlParser.events();
    return this._events;
  }

  Future<dynamic> initPromos() async {
    if (this._promos.isEmpty) this._promos = await HtmlParser.promos();
    return this._promos;
  }

  Future<dynamic> setSearch(String name, String url, int image) async {
    UnitCache<List<NodeInfo>> cacheUnit = this._cache.getSearchByUrl(url);
    if (cacheUnit == null) {
      List<NodeInfo> nodes = await HtmlParser.searchByWord(url);
      if (nodes.isNotEmpty) {
        String oldUrl = _oldestUrl(
            this._cache.search.keys, (el) => this._cache.getSearchByUrl(el));
        cacheUnit = this._cache.search[oldUrl];
        cacheUnit.name = name;
        cacheUnit.element = nodes;
        cacheUnit.icon = image;
        this._cache.changeSearch(oldUrl, url, cacheUnit);
        cacheUnit.updateDate();
        _storeCache();
      } else
        return [];
    } else
      cacheUnit.updateDate();
    this._cache.lastSearch = url;
    return getSearch();
  }

  Future<List<dynamic>> setLeafInfo(String name, String url, int image) async {
    UnitCache<List<LeafInfo>> cacheUnit = this._cache.getLeafsByUrl(url);
    if (cacheUnit == null) {
      List<LeafInfo> leafs = await HtmlParser.leafsByWord(url);
      if (leafs.isNotEmpty) {
        String oldUrl = _oldestUrl(
            this._cache.leafs.keys, (el) => this._cache.getLeafsByUrl(el));
        cacheUnit = this._cache.leafs[oldUrl];
        cacheUnit.name = name;
        cacheUnit.icon = image;
        for(LeafInfo leaf in cacheUnit.element) {
          _removeImage(leaf);
        }
        cacheUnit.element = leafs;
        for(LeafInfo leaf in leafs) {
          await _saveImage(leaf);
        }
        this._cache.changeLeafs(oldUrl, url, cacheUnit);
      } else
        return [];
    }
    cacheUnit.updateDate();
    _storeCache();
    this._cache.lastLeafs = url;
    return getLeafs();
  }

  String _oldestUrl(Iterable<String> list, UnitCache Function(String) func) {
    String oldUrl;
    DateTime tmpDate;
    list.forEach((el) => {
          if (tmpDate == null || tmpDate.isAfter(func(el).date))
            {
              tmpDate = func(el).date,
              oldUrl = el,
            }
        });
    return oldUrl;
  }

  Future<dynamic> addOffline(LeafInfo leafInfo) async {
    this._cache.addOffline(leafInfo);
    await _saveImage(leafInfo);
    _storeOffline();
    return this.getOffline();
  }

  void removeOffline(LeafInfo leafInfo) {
    _removeImage(leafInfo);
    this._cache.removeOffline(leafInfo);
    _storeOffline();
  }

  List<NodeInfo> getEvents() {
    return this._events;
  }

  List<NodeInfo> getPromos() {
    return this._promos;
  }

  List<NodeInfo> getOrganizations() {
    return this._cache.organizations;
  }

  List<NodeInfo> getCategories() {
    return this._cache.categories;
  }

  List<NodeInfo> getSearch() {
    return this._cache.getSearchByUrl(this._cache.lastSearch).element;
  }

  List<MapEntry<String, dynamic>> getLastSearched() =>
      this._cache.search.entries.toList();

  List<MapEntry<String, dynamic>> getLastLeafs() =>
      this._cache.leafs.entries.toList();

  List<LeafInfo> getLeafs() {
    return this._cache.getLeafsByUrl(this._cache.lastLeafs).element;
  }

  List<LeafInfo> getOffline() => this._cache.offline;

  Future<dynamic> _loadCache() async {
    Cache tmpCache =
        DeserializeCache.deserialize(await StoreManager.load(FNCACHE));
    await _loadLastInfoFrom(tmpCache);
    return this._cache.lastLeafs;
  }

  Future<dynamic> _loadLastInfoFrom(Cache tmpCache) async {
    this._cache.search = tmpCache.search;
    for (MapEntry<String, dynamic> entry in this._cache.search.entries) {
      entry.value.element = await HtmlParser.searchByWord(entry.key);
    }
    this._cache.lastSearch = tmpCache.lastSearch;
    this._cache.leafs = tmpCache.leafs;
    for (MapEntry<String, dynamic> entry in this._cache.leafs.entries) {
      List<LeafInfo> leafs = await HtmlParser.leafsByWord(entry.key);
      entry.value.element = leafs;
    }
    this._cache.lastLeafs = tmpCache.lastLeafs;
    return tmpCache.lastLeafs;
  }

  Future _storeCache() async {
    return await StoreManager.store(
        SerializeCache.serialize(this._cache), FNCACHE);
  }

  Future _loadOffline() async {
    this._cache.offline =
        DeserializeOffline.deserialize(await StoreManager.load(FNOFFLINE));
  }

  Future _storeOffline() async {
    return await StoreManager.store(
        SerializeOffline.serialize(this._cache.offline), FNOFFLINE);
  }

  Future<dynamic> _saveImage(LeafInfo leafInfo) async {
    var byte;
    if (leafInfo.image != null) {
      leafInfo.imageFile = await StoreManager.localFile(
          leafInfo.image.substring(leafInfo.image.lastIndexOf('/') + 1));
      byte = await HttpRequest.getImage(leafInfo.image);
      StoreManager.storeBytes(byte, leafInfo.imageFile.path);
    }
    return byte;
  }

  void _removeImage(LeafInfo leafInfo) {
    if (leafInfo.imageFile != null) {
      StoreManager.localFile(leafInfo.imageFile.path)
          .then((value) => value.delete());
    }
  }
}
