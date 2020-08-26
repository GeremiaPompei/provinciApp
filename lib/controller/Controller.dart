import 'dart:convert';
import 'package:MC/model/Persistence/DeserializeCache.dart';
import 'package:MC/model/Persistence/DeserializeOffline.dart';
import 'package:MC/model/Persistence/SerializeCache.dart';
import 'package:MC/model/Persistence/SerializeOffline.dart';
import 'package:MC/model/Persistence/StoreManager.dart';
import 'package:MC/model/UnitCache.dart';
import 'package:MC/model/web/HtmlParser.dart';
import 'package:MC/model/web/HttpRequest.dart';
import 'package:MC/model/LeafInfo.dart';
import 'package:MC/model/Cache.dart';
import 'package:MC/model/NodeInfo.dart';

class Controller {
  Cache _cache;
  List<NodeInfo> _events;
  List<NodeInfo> _promos;

  Controller() {
    _events = [];
    _promos = [];
    _cache = new Cache(5, 5);
  }

  Future<dynamic> init() async {
    this._cache.initOrganizations(await HtmlParser.organizations());
    this._cache.initCategories(await HtmlParser.categories());
    await loadCacheLastInfo();
    storeCache();
    return this.getCategories();
  }

  Future<dynamic> initOffline() async {
    try {
      for (var el in this._cache.offline) {
        List<LeafInfo> list = await HtmlParser.leafsByWord(el.sourceUrl);
        el = list[el.sourceIndex];
      }
    } catch (e) {}
    loadOffline();
    return getOffline();
  }

  Future<dynamic> initEvents() async {
    this._events = await HtmlParser.events();
    return this._events;
  }

  Future<dynamic> initPromos() async {
    this._promos = await HtmlParser.promos();
    return this._promos;
  }

  Future setSearch(String name, String url) async {
    try {
      UnitCache<List<NodeInfo>> cacheUnit = this._cache.getSearchByUrl(url);
      if (cacheUnit == null) {
        List<NodeInfo> nodes = await HtmlParser.searchByWord(url);
        String oldUrl = oldestUrl(
            this._cache.search.keys, (el) => this._cache.getSearchByUrl(el));
        cacheUnit = this._cache.search[oldUrl];
        cacheUnit.name = name;
        cacheUnit.element = nodes;
        this._cache.changeSearch(oldUrl, url, cacheUnit);
        cacheUnit.updateDate();
        storeCache();
      } else
        cacheUnit.updateDate();
      this._cache.lastSearch = url;
    } catch (e) {
      print(e.toString());
    }
    return getSearch();
  }

  Future setLeafInfo(String name, String url) async {
    UnitCache<List<LeafInfo>> cacheUnit = this._cache.getLeafsByUrl(url);
    if (cacheUnit == null) {
      List<LeafInfo> leafs = await HtmlParser.leafsByWord(url);
      String oldUrl = oldestUrl(
          this._cache.leafs.keys, (el) => this._cache.getLeafsByUrl(el));
      cacheUnit = this._cache.leafs[oldUrl];
      cacheUnit.name = name;
      cacheUnit.element = leafs;
      this._cache.changeLeafs(oldUrl, url, cacheUnit);
    }
    cacheUnit.updateDate();
    storeCache();
    this._cache.lastLeafs = url;
    return getLeafs();
  }

  String oldestUrl(Iterable<String> list, UnitCache Function(String) func) {
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
    storeOffline();
    return this.getOffline();
  }

  Future<dynamic> removeOffline(LeafInfo leafInfo) async {
    this._cache.removeOffline(leafInfo);
    storeOffline();
    return this.getOffline();
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

  Future loadCacheLastInfo() async {
    Cache tmpCache =
        DeserializeCache.deserialize(await StoreManager.load('cache.json'));
    this._cache.search = tmpCache.search;
    this._cache.search.forEach((key, value) async {
      value.element = await HtmlParser.searchByWord(key);
    });
    this._cache.lastSearch = tmpCache.lastSearch;
    this._cache.leafs = tmpCache.leafs;
    this._cache.leafs.forEach((key, value) async {
      List<LeafInfo> leafs = await HtmlParser.leafsByWord(key);
      value.element = leafs;
    });
    this._cache.lastLeafs = tmpCache.lastLeafs;
  }

  Future loadCache() async {
    this._cache =
        DeserializeCache.deserialize(await StoreManager.load('cache.json'));
  }

  Future storeCache() async {
    return await StoreManager.store(
        SerializeCache.serialize(this._cache), 'cache.json');
  }

  Future loadOffline() async {
    this._cache.offline =
        DeserializeOffline.deserialize(await StoreManager.load('Offline.json'));
  }

  Future storeOffline() async {
    return await StoreManager.store(
        SerializeOffline.serialize(this._cache.offline), 'Offline.json');
  }
}
