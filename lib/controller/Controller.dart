import 'dart:convert';

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
    initOrganizations();
    initCategories();
  }

  void initOrganizations() async {
    this.cache.initOrganizations(await HtmlParser.organizations());
  }

  void initCategories() async {
    this.cache.initCategories(await HtmlParser.categories());
  }

  Future setSearch(String word) async {
    UnitCache<List<NodeInfo>> cacheUnit = this.cache.getSearch(word);
    if (cacheUnit == null) {
      cacheUnit = new UnitCache();
      List<NodeInfo> nodes = await HtmlParser.searchByWord(word);
      String oldUrl;
      DateTime tmpDate;
      this.cache.search.keys.forEach((el) => {
        if (tmpDate == null ||
            tmpDate.isAfter(this.cache.getSearch(el).getDate()))
          {
            tmpDate = this.cache.getSearch(el).getDate(),
            oldUrl = el,
          }
      });
      cacheUnit.setElement(nodes);
      this.cache.changeSearch(oldUrl,word, cacheUnit);
    }
    cacheUnit.updateDate();
    this.lastSearch = word;
  }

  Future setLeafInfo(String url,
      LeafInfo Function(Map<String, dynamic> parsedJson) func) async {
    UnitCache<List<LeafInfo>> cacheUnit = this.cache.getLeafs(url);
    if (cacheUnit == null) {
      cacheUnit = new UnitCache();
      List<dynamic> tmp = json.decode(await HttpRequest.getJson(url));
      List<LeafInfo> leafs = tmp.map((i) => func(i)).toList();
      String oldUrl;
      DateTime tmpDate;
      this.cache.leafs.keys.forEach((el) => {
        if (tmpDate == null ||
            tmpDate.isAfter(this.cache.getLeafs(el).getDate()))
          {
            tmpDate = this.cache.getLeafs(el).getDate(),
            oldUrl = el,
          }
      });
      cacheUnit.setElement(leafs);
      this.cache.changeLeafs(oldUrl,url, cacheUnit);
    }
    cacheUnit.updateDate();
    this.lastLeafs = url;
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
}
