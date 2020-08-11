import 'dart:convert';

import 'package:MC/model/UnitCache.dart';
import 'package:MC/model/web/HtmlParser.dart';
import 'package:MC/model/web/HttpRequest.dart';
import 'package:MC/model/LeafInfo.dart';
import 'package:MC/model/Cache.dart';
import 'package:MC/model/NodeInfo.dart';

class Controller {
  Cache cache;

  Controller() {
    cache = new Cache();
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
//    UnitCache<List<NodeInfo>> cacheUnit = this.cache.getSearch(word);
//    if (cacheUnit == null) {
//      List<NodeInfo> nodes = await HtmlParser.searchByWord(word);
//      String oldUrl;
//      DateTime tmpDate;
//      this.cache.search.keys.forEach((el) => {
//            if (tmpDate == null ||
//                tmpDate.isAfter(this.cache.getSearch(el).getDate()))
//              tmpDate = this.cache.getSearch(el).getDate(),
//            oldUrl = el,
//          });
//      this.cache.removeSearch(oldUrl);
//      cacheUnit.setElement(nodes);
//      this.cache.putSearch(word, cacheUnit);
//    }
//    cacheUnit.setDate(DateTime.now());

  cache.setSearch(await HtmlParser.searchByWord(word));
  }

  Future setLeafInfo(String url,
      LeafInfo Function(Map<String, dynamic> parsedJson) func) async {
    List<dynamic> leafs = json.decode(await HttpRequest.getJson(url));
    this.cache.setLeafs(leafs.map((i) => func(i)).toList());
  }

  List<NodeInfo> getOrganizations() {
    return this.cache.getOrganizations();
  }

  List<NodeInfo> getCategories() {
    return this.cache.getCategories();
  }

  List<NodeInfo> getSearch() {
    return this.cache.search;
  }

  List<LeafInfo> getLeafs() {
    return this.cache.leafs;
  }


//  UnitCache<List<NodeInfo>> getSearch(String url) {
//    return this.cache.getSearch(url);
//  }
//
//  UnitCache<List<LeafInfo>> getLeafs(String url) {
//    return this.cache.getLeafs(url);
//  }
}
