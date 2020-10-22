import 'dart:convert';

import '../risorsa.dart';

class SerializeOffline {
  static String serialize(List<Risorsa> leafs) {
    List<Map<String, dynamic>> listMap = [];
    leafs.forEach((element) {
      Map<String, dynamic> jsonMap = {
        'Source Url': element.idUrl,
        'Source Index': element.idIndice.toString(),
        'List Element': element.json,
        'Image Path': element.immagineFile == null ? '': element.immagineFile.path,
      };
      listMap.add(jsonMap);
    });
    return json.encode(listMap);
  }
}