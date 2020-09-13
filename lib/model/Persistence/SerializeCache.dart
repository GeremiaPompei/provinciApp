import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:MC/model/Cache.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:MC/model/UnitCache.dart';
import '../LeafInfo.dart';

class SerializeCache {
  static String serialize(Cache cache) {
    Map<String, dynamic> jsonMap = {};
    jsonMap['Organizations'] = _serializeListNodeInfo(cache.organizations);
    jsonMap['Categories'] = _serializeListNodeInfo(cache.categories);
    jsonMap['Last Search'] = cache.lastSearch;
    jsonMap['Last Leafs'] = cache.lastLeafs;
    jsonMap['Search'] =
        _serializeMapInfo(cache.search, (list) => _serializeListNodeInfo(list));
    jsonMap['Leafs'] =
        _serializeMapInfo(cache.leafs, (list) => _serializeListLeafInfo(list));
    return json.encode(jsonMap);
  }

  static List<Map> _serializeListNodeInfo(List<NodeInfo> listIn) {
    List<Map> listRes = [];
    listIn.forEach((element) {
      Map<String, dynamic> mapTmp = {
        'Name': element.name,
        'Description': element.description,
        'Url': element.url,
        'Image': element.image
      };
      listRes.add(mapTmp);
    });
    return listRes;
  }

  static List<Map> _serializeListLeafInfo(List<LeafInfo> listIn) {
    List<Map> listRes = [];
    listIn.forEach((element) {
      Map<String, dynamic> mapTmp = {
        'Json': element.json,
        'Image File': element.imageFile,
      };
      listRes.add(mapTmp);
    });
    return listRes;
  }

  static List<Map> _serializeMapInfo<T>(
      Map<String, UnitCache<List<T>>> mapIn, List<Map> Function(List<T>) func) {
    List<Map> listRes = [];
    mapIn.keys.forEach((element) {
      Map<String, dynamic> mapTmp = {
        'Key': element,
        'Unit Cache': {
          'Date': DateFormat('yyy-MM-dd HH:mm:ss').format(mapIn[element].date),
          'Name': mapIn[element].name,
          'Icon': mapIn[element].icon,
          'Element': func(mapIn[element].element)
        }
      };
      listRes.add(mapTmp);
    });
    return listRes;
  }
}
