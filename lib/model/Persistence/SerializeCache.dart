import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:MC/model/Cache.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:MC/model/UnitCache.dart';
import '../LeafInfo.dart';

class SerializeCache {

  static Future<String> serialize(Cache cache) async {
    Map<String, dynamic> jsonMap = {};
    jsonMap['Organizations'] =
        await _serializeListNodeInfo(cache.organizations);
    jsonMap['Categories'] = await _serializeListNodeInfo(cache.categories);
    jsonMap['Last Search'] = cache.lastSearch;
    jsonMap['Last Leafs'] = cache.lastLeafs;
    jsonMap['Search'] =
        await _serializeMapInfo(cache.search, _serializeListNodeInfo);
    jsonMap['Leafs'] =
        await _serializeMapInfo(cache.leafs, _serializeListLeafInfo);
    return json.encode(jsonMap);
  }

  static Future<dynamic> _serializeListNodeInfo(dynamic listIn) async {
    List<Map> listRes = [];
    for (var e in listIn) {
      var element = await e;
      Map<String, dynamic> mapTmp = {
        'Name': element.name,
        'Description': element.description,
        'Url': element.url,
        'Image': element.image
      };
      listRes.add(mapTmp);
    }
    return listRes;
  }

  static Future<dynamic> _serializeListLeafInfo(dynamic listIn) async {
    List<Map> listRes = [];
    for (var element in listIn) {
      Map<String, dynamic> mapTmp = {
        'Json': element.json,
        'Image File': element.imageFile == null
            ? null.toString()
            : element.imageFile.path,
      };
      listRes.add(mapTmp);
    }
    return listRes;
  }

  static Future<dynamic> _serializeMapInfo(
      Map mapIn, Function(dynamic) func) async {
    List<Map> listRes = [];
    for (var element in mapIn.keys.toList()) {
      Map<String, dynamic> mapTmp = {
        'Key': element,
        'Unit Cache': {
          'Date': DateFormat('yyy-MM-dd HH:mm:ss').format(mapIn[element].date),
          'Name': mapIn[element].name,
          'Icon': mapIn[element].icon.toString(),
          'Element': await func(mapIn[element].element)
        }
      };
      listRes.add(mapTmp);
    }
    return listRes;
  }
}
