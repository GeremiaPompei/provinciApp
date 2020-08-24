import 'dart:convert';
import '../Cache.dart';
import '../LeafInfo.dart';
import '../NodeInfo.dart';
import '../UnitCache.dart';

class DeserializeCache {
  static Cache deserialize(String contents) {
    Map<String, dynamic> jsonMap = json.decode(contents);
    Cache cache = Cache(
        int.parse(jsonMap['Search Count']), int.parse(jsonMap['Leafs Count']));
    cache.setLastSearch(jsonMap['Last Search']);
    cache.setLastLeafs(jsonMap['Last Leafs']);
    cache.setSearch(deserializeMapInfo(
        jsonMap['Search']));
    cache.setLeafs(deserializeMapInfo(
        jsonMap['Leafs']));
    return cache;
  }

  static Map<String, UnitCache<List<T>>> deserializeMapInfo<T>(
      List listIn) {
    Map<String, UnitCache<List<T>>> mapRes = {};
    listIn.forEach((element) {
      mapRes[element['Key']] = UnitCache(
          [],
          DateTime.parse(element['Unit Cache']['Date']),
          element['Unit Cache']['Name']);
    });
    return mapRes;
  }
}
