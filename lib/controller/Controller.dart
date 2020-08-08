import 'dart:convert';

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
    this.cache.setSearch(await HtmlParser.searchByWord(word));
  }

  Future setLeafInfo(String url,LeafInfo Function(Map<String, dynamic> parsedJson) func) async {
    List<dynamic> leafs = json
        .decode(await HttpRequest.getJson(url));
    this.cache.setLeafs(leafs.map((i) => func(i))
        .toList());
  }

  List<NodeInfo> getOrganizations() {
    return this.cache.organizations;
  }

  List<NodeInfo> getCategories() {
    return this.cache.categories;
  }

  List<NodeInfo> getSearch() {
    return this.cache.search;
  }

  List<LeafInfo> getLeafs() {
    return cache.leafs;
  }
}
