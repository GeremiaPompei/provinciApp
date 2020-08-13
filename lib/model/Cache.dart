import 'package:MC/model/LeafInfo.dart';
import 'package:MC/model/NodeInfo.dart';

import 'UnitCache.dart';

class Cache {
  List<NodeInfo> categories;
  List<NodeInfo> organizations;
  Map<String, UnitCache<List<NodeInfo>>> search;
  Map<String, UnitCache<List<LeafInfo>>> leafs;

  Cache(int searchCount, int leafsCount) {
    this.categories = [];
    this.organizations = [];
    this.search = {};
    this.leafs = {};
    initMap<List<NodeInfo>>(this.search, searchCount);
    initMap<List<LeafInfo>>(this.leafs, leafsCount);
  }

  void initMap<T>(Map<String,UnitCache<T>> map, int num) {
    for (int i = 0; i < num; i++) {
      map['Empty'] = new UnitCache<T>();
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

  void changeLeafs(
      String oldUrl, String newUrl, UnitCache<List<dynamic>> leafs) {
    this.leafs.remove(oldUrl);
    this.leafs[newUrl] = leafs;
  }

  List<NodeInfo> getOrganizations() {
    return this.organizations;
  }

  List<NodeInfo> getCategories() {
    return this.categories;
  }

  UnitCache<List<NodeInfo>> getSearch(String url) {
    return this.search[url];
  }

  UnitCache<List<LeafInfo>> getLeafs(String url) {
    return this.leafs[url];
  }
}
