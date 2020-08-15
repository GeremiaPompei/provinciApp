import 'dart:convert';
import 'package:MC/model/Persistence/DeserializeCache.dart';
import 'package:MC/model/Persistence/SerializeCache.dart';
import 'package:MC/model/Persistence/StoreManager.dart';
import 'package:MC/model/UnitCache.dart';
import 'package:MC/model/web/HtmlParser.dart';
import 'package:MC/model/web/HttpRequest.dart';
import 'package:MC/model/LeafInfo.dart';
import 'package:MC/model/Cache.dart';
import 'package:MC/model/NodeInfo.dart';

class Controller {
  Cache cache;

  Controller() {
    cache = new Cache(5, 5);
    init();
  }

  void init() async {
    try {
      this.cache.initOrganizations(await HtmlParser.organizations());
      this.cache.initCategories(await HtmlParser.categories());
      store();
    } catch (e) {
      load();
    }
  }

  Future setSearch(String url) async {
    try {
      UnitCache<List<NodeInfo>> cacheUnit = this.cache.getSearchByUrl(url);
      if (cacheUnit == null) {
        List<NodeInfo> nodes = await HtmlParser.searchByWord(url);
        String oldUrl = oldestUrl(
            this.cache.search.keys, (el) => this.cache.getSearchByUrl(el));
        cacheUnit = this.cache.search[oldUrl];
        cacheUnit.setElement(nodes);
        this.cache.changeSearch(oldUrl, url, cacheUnit);
        cacheUnit.updateDate();
        store();
      } else
        cacheUnit.updateDate();
      this.cache.setLastSearch(url);
    } catch (e) {
      print(e.toString());
    }
  }

  Future setLeafInfo(String url,
      LeafInfo Function(Map<String, dynamic> parsedJson) func) async {
    UnitCache<List<LeafInfo>> cacheUnit = this.cache.getLeafsByUrl(url);
    if (cacheUnit == null) {
      List<dynamic> tmp = json.decode(await HttpRequest.getJson(url));
      List<LeafInfo> leafs = tmp.map((i) => func(i)).toList();
      String oldUrl = oldestUrl(
          this.cache.leafs.keys, (el) => this.cache.getLeafsByUrl(el));
      cacheUnit = this.cache.leafs[oldUrl];
      cacheUnit.setElement(leafs);
      this.cache.changeLeafs(oldUrl, url, cacheUnit);
    }
    cacheUnit.updateDate();
    store();
    this.cache.setLastLeafs(url);
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
    return this.cache.getSearchByUrl(this.cache.getLastSearch()).getElement();
  }

  List<LeafInfo> getLeafs() {
    return this.cache.getLeafsByUrl(this.cache.getLastLeafs()).getElement();
  }

  Future load() async {
    this.cache =
        DeserializeCache.deserialize(await StoreManager.load());
  }

  Future store() async {
    return await StoreManager.store(
        SerializeCache.serialize(this.cache));
  }
}
