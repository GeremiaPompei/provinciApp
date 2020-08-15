import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:MC/model/Cache.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:MC/model/UnitCache.dart';

class SerializeDeserializerCache {
  static Cache deserialize(String contents) {
    Map<String, dynamic> jsonMap = json.decode(contents);
    Cache cache = Cache(5, 5);
    cache.initOrganizations(deserializeNodeListInfo(jsonMap['Organizations']));
    cache.initCategories(deserializeNodeListInfo(jsonMap['Categories']));
    cache.setSearch(deserializeMapNodeInfo(jsonMap['Search']));
    return cache;
  }

  static List<NodeInfo> deserializeNodeListInfo(List listIn) {
    List<NodeInfo> listRes = [];
    listIn.forEach((element) {
      listRes.add(
          NodeInfo(element['Name'], element['Description'], element['Url']));
    });
    return listRes;
  }

  static Map<String, UnitCache<List<NodeInfo>>> deserializeMapNodeInfo(
      List listIn) {
    Map<String, UnitCache<List<NodeInfo>>> mapRes = {};
    listIn.forEach((element) {
      var el = deserializeNodeListInfo(element['Unit Cache']['Elements']);
      mapRes[element['Key']] =
          UnitCache(el, DateTime.parse(element['Unit Cache']['Date']));
    });
    return mapRes;
  }

  static String serialize(Cache cache) {
    Map<String, dynamic> jsonMap = {};
    jsonMap['Organizations'] = serializeListNodeInfo(cache.getOrganizations());
    jsonMap['Categories'] = serializeListNodeInfo(cache.getCategories());
    jsonMap['Search'] = serializeMapNodeInfo(cache.getSearch());
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

  static List<Map> serializeMapNodeInfo(
      Map<String, UnitCache<List<NodeInfo>>> mapIn) {
    List<Map> listRes = [];
    mapIn.keys.forEach((element) {
      Map<String, dynamic> mapTmp = {
        'Key': element,
        'Unit Cache': {
          'Date':
              DateFormat('yyy-MM-dd HH:mm:ss').format(mapIn[element].getDate()),
          'Elements': serializeListNodeInfo(mapIn[element].getElement())
        }
      };
      listRes.add(mapTmp);
    });
    return listRes;
  }
}
