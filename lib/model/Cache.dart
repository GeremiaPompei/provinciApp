import 'package:MC/model/LeafInfo.dart';
import 'package:MC/model/NodeInfo.dart';

import 'Persistence/StoreManager.dart';
import 'UnitCache.dart';

class Cache {
  List<NodeInfo> _categories;
  List<NodeInfo> _organizations;
  Map<String, UnitCache<List<NodeInfo>>> _search;
  Map<String, UnitCache<List<LeafInfo>>> _leafs;
  List<LeafInfo> _offline;
  String _lastSearch;
  String _lastLeafs;

  Cache() {
    this._offline = [];
    this._categories = [];
    this._organizations = [];
    this._search = {};
    this._leafs = {};
  }

  void initOrganizations(List<NodeInfo> nodes) {
    this._organizations = nodes;
  }

  void initCategories(List<NodeInfo> nodes) {
    this._categories = nodes;
  }

  void changeSearch(
      String oldUrl, String newUrl, UnitCache<List<NodeInfo>> nodes) {
    this._search.remove(oldUrl);
    this._search[newUrl] = nodes;
  }

  void changeLeafs(
      String oldUrl, String newUrl, UnitCache<List<dynamic>> leafs) async {
    this._leafs.remove(oldUrl);
    this._leafs[newUrl] = leafs;
  }

  void addOffline(LeafInfo leafInfo) => this._offline.add(leafInfo);

  void removeOffline(LeafInfo leafInfo) => this._offline.remove(leafInfo);

  UnitCache<List<NodeInfo>> getSearchByUrl(String url) => this._search[url];

  UnitCache<List<LeafInfo>> getLeafsByUrl(String url) => this._leafs[url];

  String get lastLeafs => _lastLeafs;

  String get lastSearch => _lastSearch;

  List<LeafInfo> get offline => _offline;

  Map<String, UnitCache<List<LeafInfo>>> get leafs => _leafs;

  Map<String, UnitCache<List<NodeInfo>>> get search => _search;

  List<NodeInfo> get organizations => _organizations;

  List<NodeInfo> get categories => _categories;

  set search(Map<String, UnitCache<List<NodeInfo>>> value) {
    _search = value;
  }

  set leafs(Map<String, UnitCache<List<LeafInfo>>> value) {
    _leafs = value;
  }

  set lastSearch(String value) {
    _lastSearch = value;
  }

  set lastLeafs(String value) {
    _lastLeafs = value;
  }

  set offline(List<LeafInfo> value) {
    _offline = value;
  }
}
