import 'dart:convert';
import 'package:MC/model/SerializeDeserializeCache.dart';
import 'package:MC/model/StoreManager.dart';
import 'package:MC/model/UnitCache.dart';
import 'package:MC/model/web/HtmlParser.dart';
import 'package:MC/model/web/HttpRequest.dart';
import 'package:MC/model/LeafInfo.dart';
import 'package:MC/model/Cache.dart';
import 'package:MC/model/NodeInfo.dart';

class Controller {
  Cache cache;
  String lastSearch = 'Empty';
  String lastLeafs = 'Empty';

  Controller() {
    cache = new Cache(5, 5);
    init();
  }

  void init() async {
    try {
      this.cache.initOrganizations(await HtmlParser.organizations());
      this.cache.initCategories(await HtmlParser.categories());
      await store();
    } catch (e) {
      await load();
    }
  }

  Future setSearch(String url) async {
    UnitCache<List<NodeInfo>> cacheUnit = this.cache.getSearch(url);
    if (cacheUnit == null) {
      cacheUnit = new UnitCache();
      List<NodeInfo> nodes = await HtmlParser.searchByWord(url);
      String oldUrl =
          oldestUrl(this.cache.search.keys, (el) => this.cache.getSearch(el));
      cacheUnit.setElement(nodes);
      this.cache.changeSearch(oldUrl, url, cacheUnit);
    }
    cacheUnit.updateDate();
    this.lastSearch = url;
    await store();
  }

  Future setLeafInfo(String url,
      LeafInfo Function(Map<String, dynamic> parsedJson) func) async {
    UnitCache<List<LeafInfo>> cacheUnit = this.cache.getLeafs(url);
    if (cacheUnit == null) {
      cacheUnit = new UnitCache();
      List<dynamic> tmp = json.decode(await HttpRequest.getJson(url));
      List<LeafInfo> leafs = tmp.map((i) => func(i)).toList();
      String oldUrl =
          oldestUrl(this.cache.leafs.keys, (el) => this.cache.getLeafs(el));
      cacheUnit.setElement(leafs);
      this.cache.changeLeafs(oldUrl, url, cacheUnit);
    }
    cacheUnit.updateDate();
    this.lastLeafs = url;
    await store();
  }

  String oldestUrl(Iterable<String> list, UnitCache Function(String) func) {
    String oldUrl;
    DateTime tmpDate;
    list.forEach((el) => {
          if (tmpDate == null || tmpDate.isAfter(func(el).getDate()))
            {
              tmpDate = func(el).getDate(),
              oldUrl = el,
            }
        });
    return oldUrl;
  }

  List<NodeInfo> getOrganizations() {
    return this.cache.getOrganizations();
  }

  List<NodeInfo> getCategories() {
    return this.cache.getCategories();
  }

  List<NodeInfo> getSearch() {
    return this.cache.getSearch(this.lastSearch).getElement();
  }

  List<LeafInfo> getLeafs() {
    return this.cache.getLeafs(this.lastLeafs).getElement();
  }

  Future load() async {
    this.cache =
        SerializeDeserializerCache.deserialize(await StoreManager.load());
  }

  Future store() async {
    return await StoreManager.store(
        SerializeDeserializerCache.serialize(this.cache));
  }
}
