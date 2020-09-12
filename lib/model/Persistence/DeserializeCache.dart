import 'dart:convert';
import '../Cache.dart';
import '../LeafInfo.dart';
import '../NodeInfo.dart';
import '../UnitCache.dart';

class DeserializeCache {
  static Cache deserialize(String contents) {
    Map<String, dynamic> jsonMap = json.decode(contents);
    Cache cache = Cache();
    cache.initOrganizations(_deserializeNodeListInfo(jsonMap['Organizations']));
    cache.initCategories(_deserializeNodeListInfo(jsonMap['Categories']));
    cache.lastSearch = jsonMap['Last Search'];
    cache.lastLeafs = jsonMap['Last Leafs'];
    cache.search = _deserializeMapInfo(
        jsonMap['Search'], (el,s) => _deserializeNodeListInfo(el));
    cache.leafs = _deserializeMapInfo(
        jsonMap['Leafs'],
        (el,s) =>
            _deserializeLeafListInfo(el, s));
    return cache;
  }

  static List<NodeInfo> _deserializeNodeListInfo(List listIn) {
    List<NodeInfo> listRes = [];
    listIn.forEach((element) {
      listRes.add(NodeInfo(element['Name'], element['Description'],
          element['Url'], element['Image']));
    });
    return listRes;
  }

  static List<LeafInfo> _deserializeLeafListInfo(
      List listIn, String url) {
    List<LeafInfo> listRes = [];
    for (int i = 0; i < listIn.length; i++) {
      listRes.add(LeafInfo(listIn[i], url, i));
    }
    return listRes;
  }

  static Map<String, UnitCache<List<T>>> _deserializeMapInfo<T>(
      List listIn, List<T> Function(List,String) func) {
    Map<String, UnitCache<List<T>>> mapRes = {};
    listIn.forEach((element) {
      List el = func(element['Unit Cache']['Element'],element['Key']);
      mapRes[element['Key']] = UnitCache(
          el,
          DateTime.parse(element['Unit Cache']['Date']),
          element['Unit Cache']['Name'],
          element['Unit Cache']['Icon']);
    });
    return mapRes;
  }
}
