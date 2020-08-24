import 'package:MC/model/LeafInfo.dart';
import 'package:MC/model/NodeInfo.dart';

import 'UnitCache.dart';

class Cache {
  List<NodeInfo> categories;
  List<NodeInfo> organizations;
  Map<String, UnitCache<List<NodeInfo>>> search;
  Map<String, UnitCache<List<LeafInfo>>> leafs;
  List<LeafInfo> offline;
  int searchCount;
  int leafsCount;
  String lastSearch = 'Empty 0';
  String lastLeafs = 'Empty 0';

  Cache(int searchCount, int leafsCount) {
    this.offline = [];
    this.categories = [];
    this.organizations = [];
    this.search = {};
    this.leafs = {};
    this.searchCount = searchCount;
    this.leafsCount = leafsCount;
    initMap<NodeInfo>(this.search, searchCount);
    initMap<LeafInfo>(this.leafs, leafsCount);
  }

  void initMap<T>(Map<String,UnitCache<List<T>>> map, int num) {
    for (int i = 0; i < num; i++) {
      map['Empty ${i}'] = new UnitCache(List<T>(),DateTime.now(),'Empty ${i}');
    }
  }

  void initOrganizations(List<NodeInfo> nodes) {
    this.organizations = nodes;
  }

  void initCategories(List<NodeInfo> nodes) {
    this.categories = nodes;
  }

  void changeSearch(
      String oldUrl, String newUrl, UnitCache<List<NodeInfo>> nodes) {
    this.search.remove(oldUrl);
    this.search[newUrl] = nodes;
  }

  void setSearch(Map<String, UnitCache<List<NodeInfo>>> map) {
    this.search = map;
  }

  void changeLeafs(
      String oldUrl, String newUrl, UnitCache<List<dynamic>> leafs) {
    this.leafs.remove(oldUrl);
    this.leafs[newUrl] = leafs;
  }

  void setLeafs(Map<String, UnitCache<List<LeafInfo>>> map) {
    this.leafs = map;
  }

  void setLastSearch(String str) {
   this.lastSearch = str;
  }

  void setLastLeafs(String str) {
    this.lastLeafs = str;
  }

  void addOffline(LeafInfo leafInfo) => this.offline.add(leafInfo);

  void removeOffline(LeafInfo leafInfo) => this.offline.remove(leafInfo);

  List<NodeInfo> getOrganizations() {
    return this.organizations;
  }

  List<NodeInfo> getCategories() {
    return this.categories;
  }

  Map<String, UnitCache<List<NodeInfo>>> getSearch() {
    return this.search;
  }

  Map<String, UnitCache<List<LeafInfo>>> getLeafs() {
    return this.leafs;
  }

  UnitCache<List<NodeInfo>> getSearchByUrl(String url) {
    return this.search[url];
  }

  UnitCache<List<LeafInfo>> getLeafsByUrl(String url) {
    return this.leafs[url];
  }

  int getSeachCount(){
    return this.searchCount;
  }

  int getLeafsCount(){
    return this.leafsCount;
  }

  String getLastSearch() {
    return this.lastSearch;
  }

  String getLastLeafs() {
    return this.lastLeafs;
  }

  List<LeafInfo> getOffline() => this.offline;
}
