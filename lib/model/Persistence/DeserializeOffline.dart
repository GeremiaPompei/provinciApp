import 'dart:convert';
import 'dart:io';

import 'package:MC/model/LeafInfo.dart';
import 'package:MC/model/Persistence/StoreManager.dart';
import 'package:MC/model/Web/HttpRequest.dart';

class DeserializeOffline {
  static Future<List<LeafInfo>> deserialize(String contents) async {
    List<LeafInfo> listRes = [];
    List<dynamic> listIn = json.decode(contents);
    for (var element in listIn) {
      LeafInfo leaf = LeafInfo(element['List Element'], element['Source Url'],
          int.parse(element['Source Index']));
      await _deserializeImage(element, leaf);
      listRes.add(leaf);
    }
    return listRes;
  }

  static Future<dynamic> _deserializeImage(
      dynamic element, LeafInfo leaf) async {
    if (element['Image Path'] != '') {
      try {
        List<int> content = await HttpRequest.getImage(leaf.image);
        File file = await StoreManager.localFile(element['Image Path']);
        file.delete();
        StoreManager.storeBytes(content, file.path);
        leaf.imageFile = file;
      } catch (e) {
        File value = await StoreManager.localFile(element['Image Path']);
        leaf.imageFile = value;
      }
    } else
      leaf.imageFile = null;
    return leaf.imageFile;
  }
}
