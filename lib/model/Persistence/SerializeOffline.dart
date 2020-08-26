import 'dart:convert';

import '../LeafInfo.dart';

class SerializeOffline {
  static String serialize(List<LeafInfo> leafs) {
    List<Map<String, dynamic>> listMap = [];
    leafs.forEach((element) {
      Map<String, dynamic> jsonMap = {
        'Source Url': element.sourceUrl,
        'Source Index': element.sourceIndex.toString(),
        'List Element': element.json,
      };
      listMap.add(jsonMap);
    });
    return json.encode(listMap);
  }
}