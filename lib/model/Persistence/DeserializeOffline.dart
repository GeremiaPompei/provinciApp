import 'dart:convert';

import 'package:MC/model/LeafInfo.dart';

class DeserializeOffline {
  static List<LeafInfo> deserialize(String contents) {
    List<LeafInfo> listRes = [];
    List<dynamic> liostIn = json.decode(contents);
    liostIn.forEach((element) {
      listRes.add(LeafInfo(element['List Element'], element['Source Url'],
          int.parse(element['Source Index'])));
    });
    return listRes;
  }
}
