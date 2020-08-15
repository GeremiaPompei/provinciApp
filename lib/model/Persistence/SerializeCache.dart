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
    jsonMap['Organizations'] = serializeListNodeInfo(cache.getOrganizations());
    jsonMap['Categories'] = serializeListNodeInfo(cache.getCategories());
    jsonMap['Search'] = serializeMapInfo(cache.getSearch(),(el)=>serializeListNodeInfo(el));
    jsonMap['Leafs'] = serializeMapInfo(cache.getLeafs(),(el)=>serializeListLeafInfo(el));
    return json.encode(jsonMap);
  }

  static List<Map> serializeListNodeInfo(List<NodeInfo> listIn) {
    List<Map> listRes = [];
    listIn.forEach((element) {
      Map<String, dynamic> mapTmp = {
        'Name': element.name,
        'Description': element.description,
        'Url': element.url
      };
      listRes.add(mapTmp);
    });
    return listRes;
  }

  static List<Map> serializeListLeafInfo(List<LeafInfo> listIn) {
    List<Map> listRes = [];
    listIn.forEach((element) {
      Map<String, dynamic> mapTmp = {
        'Type': element.runtimeType.toString(),
        'Json': element.getJson()
      };
      listRes.add(mapTmp);
    });
    return listRes;
  }

  static List<Map> serializeMapInfo <T> (
      Map<String, UnitCache<List<T>>> mapIn,List<Map> Function(List<T>) func) {
    List<Map> listRes = [];
    mapIn.keys.forEach((element) {
      Map<String, dynamic> mapTmp = {
        'Key': element,
        'Unit Cache': {
          'Date':
          DateFormat('yyy-MM-dd HH:mm:ss').format(mapIn[element].getDate()),
          'Elements': func(mapIn[element].getElement())
        }
      };
      listRes.add(mapTmp);
    });
    return listRes;
  }
}
