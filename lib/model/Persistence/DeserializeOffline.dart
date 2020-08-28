import 'dart:convert';

import 'package:MC/model/LeafInfo.dart';
import 'package:MC/model/Persistence/StoreManager.dart';

class DeserializeOffline {
  static List<LeafInfo> deserialize(String contents) {
    List<LeafInfo> listRes = [];
    List<dynamic> liostIn = json.decode(contents);
    liostIn.forEach((element) {
      LeafInfo leaf = LeafInfo(element['List Element'], element['Source Url'],
          int.parse(element['Source Index']));
      element['Image Path']!=''?StoreManager.localFile(element['Image Path'])
          .then((value) => leaf.imageFile = value):leaf.imageFile = null;
      listRes.add(leaf);
    });
    return listRes;
  }
}
