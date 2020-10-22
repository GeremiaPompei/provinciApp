import 'dart:convert';
import 'dart:io';

import 'package:provinciApp/model/risorsa.dart';
import 'package:provinciApp/model/Persistence/StoreManager.dart';
import 'package:provinciApp/model/Web/HttpRequest.dart';

class DeserializeOffline {
  static Future<List<Risorsa>> deserialize(String contents) async {
    List<Risorsa> listRes = [];
    List<dynamic> listIn = json.decode(contents);
    for (var element in listIn) {
      Risorsa leaf = Risorsa(element['List Element'], element['Source Url'],
          int.parse(element['Source Index']));
      await _deserializeImage(element, leaf);
      listRes.add(leaf);
    }
    return listRes;
  }

  static Future<dynamic> _deserializeImage(
      dynamic element, Risorsa leaf) async {
    if (element['Image Path'] != '') {
      try {
        List<int> content = await HttpRequest.getImage(leaf.immagineUrl);
        File file = await StoreManager.localFile(element['Image Path']);
        file.delete();
        StoreManager.storeBytes(content, file.path);
        leaf.immagineFile = file;
      } catch (e) {
        File value = await StoreManager.localFile(element['Image Path']);
        leaf.immagineFile = value;
      }
    } else
      leaf.immagineFile = null;
    return leaf.immagineFile;
  }
}
