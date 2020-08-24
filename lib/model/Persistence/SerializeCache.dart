import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:MC/model/Cache.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:MC/model/UnitCache.dart';

import '../LeafInfo.dart';

class SerializeCache {

  static String serialize(Cache cache) {
    Map<String, dynamic> jsonMap = {};
    jsonMap['Search Count'] = cache.getSeachCount().toString();
    jsonMap['Leafs Count'] = cache.getLeafsCount().toString();
    jsonMap['Last Search'] = cache.getLastSearch();
    jsonMap['Last Leafs'] = cache.getLastLeafs();
    jsonMap['Search'] = serializeMapInfo(cache.getSearch());
    jsonMap['Leafs'] = serializeMapInfo(cache.getLeafs());
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
          DateFormat('yyy-MM-dd HH:mm:ss').format(mapIn[element].getDate()),
          'Name': mapIn[element].getName()
        }
      };
      listRes.add(mapTmp);
    });
    return listRes;
  }
}
