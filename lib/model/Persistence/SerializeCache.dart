import 'dart:convert';

import 'package:MC/model/Cache.dart';
import 'package:MC/model/UnitCache.dart';
import 'package:intl/intl.dart';

class SerializeCache {

  static String serialize(Cache cache) {
    Map<String, dynamic> jsonMap = {};
    jsonMap['Last Search'] = cache.lastSearch;
    jsonMap['Last Leafs'] = cache.lastLeafs;
    jsonMap['Search'] = _serializeMapInfo(cache.search);
    jsonMap['Leafs'] = _serializeMapInfo(cache.leafs);
    return json.encode(jsonMap);
  }

  static List<Map> _serializeMapInfo <T> (
      Map<String, UnitCache<List<T>>> mapIn) {
    List<Map> listRes = [];
    mapIn.keys.forEach((element) {
      Map<String, dynamic> mapTmp = {
        'Key': element,
        'Unit Cache': {
          'Date':
          DateFormat('yyy-MM-dd HH:mm:ss').format(mapIn[element].date),
          'Name': mapIn[element].name,
          'Icon': mapIn[element].icon
        }
      };
      listRes.add(mapTmp);
    });
    return listRes;
  }
}
