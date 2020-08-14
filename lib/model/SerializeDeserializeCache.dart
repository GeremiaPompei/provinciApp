import 'dart:convert';

import 'package:MC/model/Cache.dart';
import 'package:MC/model/NodeInfo.dart';

class SerializeDeserializerCache {
  static Cache deserialize(String contents) {
    Map<String, dynamic> jsonMap = json.decode(contents);
    Cache cache = Cache(5, 5);
    cache.initOrganizations(deserializeNodeInfo(jsonMap['Organizations']));
    cache.initCategories(deserializeNodeInfo(jsonMap['Categories']));
    return cache;
  }

  static List<NodeInfo> deserializeNodeInfo(List listIn) {
    List<NodeInfo> listRes = [];
    listIn.forEach((element) {
      listRes.add(
          NodeInfo(element['Name'], element['Description'], element['Url']));
    });
    return listRes;
  }

  static String serialize(Cache cache) {
    Map<String, dynamic> jsonMap = {};
    jsonMap['Organizations'] = serializeNodeInfo(cache.getOrganizations());
    jsonMap['Categories'] = serializeNodeInfo(cache.getCategories());
    return json.encode(jsonMap);
  }

  static List<Map> serializeNodeInfo(List<NodeInfo> listIn) {
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
}
