import 'package:MC/model/LeafInfo.dart';
import 'package:MC/model/NodeInfo.dart';

import 'UnitCache.dart';

class Cache {

  List<NodeInfo> categories;
  List<NodeInfo> organizations;
  List<NodeInfo> search;
  List<LeafInfo> leafs;

  Cache(){
    this.categories = [];
    this.organizations = [];
    this.search = [];
    this.leafs = [];
  }

  void initOrganizations(List<NodeInfo> nodes) {
    this.organizations = nodes;
  }

  void initCategories(List<NodeInfo> nodes){
    this.categories = nodes;
  }

  void putSearch(String url, UnitCache<List<NodeInfo>> nodes){
    //this.search[url] = nodes;
  }

  void putLeafs(String url, UnitCache<List<dynamic>> leafs) {
    //this.leafs[url] = leafs;
  }

  void removeSearch(String url){
    this.search.remove(url);
  }

  void removeLeafs(String url) {
    this.leafs.remove(url);
  }

  List<NodeInfo> getOrganizations() {
    return this.organizations;
  }

  List<NodeInfo> getCategories() {
    return this.categories;
  }

  List<NodeInfo> getSearch(String url) {
    return this.search;
  }

  List<LeafInfo> getLeafs(String url) {
    return this.leafs;
  }

  void setSearch(List<NodeInfo> nodes) {
    this.search = nodes;
  }

  void setLeafs(List<LeafInfo> leafs) {
    this.leafs = leafs;
  }

}