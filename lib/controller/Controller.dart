import 'dart:convert';

import 'package:MC/model/LeafsType/Bando.dart';
import 'package:MC/model/LeafsType/Concorso.dart';
import 'package:MC/model/LeafsType/Evento.dart';
import 'package:MC/model/LeafsType/Monumento.dart';
import 'package:MC/model/LeafsType/StrutturaRicreativa.dart';
import 'package:MC/model/web/HtmlParser.dart';
import 'package:MC/model/web/HttpRequest.dart';
import 'package:MC/model/LeafInfo.dart';
import 'package:MC/model/Ledger.dart';
import 'package:MC/model/NodeInfo.dart';

class Controller {
  Ledger ledger;

  Controller() {
    ledger = new Ledger();
    initOrganizations();
    initCategories();
  }

  void initOrganizations() async {
    this.ledger.initOrganizations(await HtmlParser.organizations());
  }

  void initCategories() async {
    this.ledger.initCategories(await HtmlParser.categories());
  }

  Future setSearch(String word) async {
    this.ledger.setSearch(await HtmlParser.searchByWord(word));
  }

  Future setLeafInfo(String url,LeafInfo Function(Map<String, dynamic> parsedJson) func) async {
    List<dynamic> leafs = json
        .decode(await HttpRequest.getJson(url));
    this.ledger.setLeafs(leafs.map((i) => func(i))
        .toList());
  }

  List<NodeInfo> getOrganizations() {
    return this.ledger.organizations;
  }

  List<NodeInfo> getCategories() {
    return this.ledger.categories;
  }

  List<NodeInfo> getSearch() {
    return this.ledger.search;
  }

  List<LeafInfo> getLeafs() {
    return ledger.leafs;
  }
}
