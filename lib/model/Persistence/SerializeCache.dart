import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:MC/model/Cache.dart';
import 'package:MC/model/UnitCache.dart';

class SerializeCache {

  static String serialize(Cache cache) {
    Map<String, dynamic> jsonMap = {};
    jsonMap['Search Count'] = cache.searchCount.toString();
    jsonMap['Leafs Count'] = cache.leafsCount.toString();
    jsonMap['Last Search'] = cache.lastSearch;
    jsonMap['Last Leafs'] = cache.lastLeafs;
    jsonMap['Search'] = serializeMapInfo(cache.search);
    jsonMap['Leafs'] = serializeMapInfo(cache.leafs);
    return json.encode(jsonMap);
  }

  static List<Map> serializeMapInfo <T> (
      Map<String, UnitCache<List<T>>> mapIn) {
    List<Map> listRes = [];
    mapIn.keys.forEach((element) {
      Map<String, dynamic> mapTmp = {
        'Key': element,
        'Unit Cache': {
          'Date':
          DateFormat('yyy-MM-dd HH:mm:ss').format(mapIn[element].date),
          'Name': mapIn[element].name
        }
      };
      listRes.add(mapTmp);
    });
    return listRes;
  }
}
