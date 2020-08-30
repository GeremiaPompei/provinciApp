import 'dart:convert';
import '../Cache.dart';
import '../UnitCache.dart';

class DeserializeCache {
  static Cache deserialize(String contents) {
    Map<String, dynamic> jsonMap = json.decode(contents);
    Cache cache = Cache();
    cache.lastSearch = jsonMap['Last Search'];
    cache.lastLeafs = jsonMap['Last Leafs'];
    cache.search = deserializeMapInfo(jsonMap['Search']);
    cache.leafs = deserializeMapInfo(jsonMap['Leafs']);
    return cache;
  }

  static Map<String, UnitCache<List<T>>> deserializeMapInfo<T>(List listIn) {
    Map<String, UnitCache<List<T>>> mapRes = {};
    listIn.forEach((element) {
      mapRes[element['Key']] = UnitCache([],
          DateTime.parse(element['Unit Cache']['Date']),
          element['Unit Cache']['Name']);
    });
    return mapRes;
  }
}
