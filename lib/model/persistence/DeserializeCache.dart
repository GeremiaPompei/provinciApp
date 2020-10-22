import 'dart:convert';
import 'package:provinciApp/model/Persistence/StoreManager.dart';

import '../cache.dart';
import '../risorsa.dart';
import '../pacchetto.dart';
import '../unit_cache.dart';

class DeserializeCache {
  static Future<Cache> deserialize(String contents) async {
    Map<String, dynamic> jsonMap = json.decode(contents);
    Cache cache = new Cache();
    cache.initComuni((await _deserializeNodeListInfo(jsonMap['Organizations']))
        .map((e) async => e)
        .toList());
    cache.initCategorie((await _deserializeNodeListInfo(jsonMap['Categories']))
        .map((e) async => e)
        .toList());
    cache.keyUltimiPacchetti = jsonMap['Last Search'];
    cache.keyUltimeRisorse = jsonMap['Last Leafs'];
    cache.pacchetti = await _deserializeMapInfo(
        jsonMap['Search'], (el, s) async => await _deserializeNodeListInfo(el));
    cache.risorse = await _deserializeMapInfo(jsonMap['Leafs'],
        (el, s) async => await _deserializeLeafListInfo(el, s));
    return cache;
  }

  static Future<List<Pacchetto>> _deserializeNodeListInfo(List listIn) async {
    List<Pacchetto> listRes = [];
    listIn.forEach((element) {
      listRes.add(Pacchetto(
          element['Name'], element['Description'], element['Url'],
          immagineUrl: element['Image']));
    });
    return listRes;
  }

  static Future<List<Risorsa>> _deserializeLeafListInfo(
      List listIn, String url) async {
    List<Risorsa> listRes = [];
    for (int i = 0; i < listIn.length; i++) {
      Risorsa leaf = Risorsa(listIn[i]['Json'], url, i);
      if (listIn[i]['Image File'] != 'null')
        leaf.immagineFile = await StoreManager.localFile(listIn[i]['Image File']);
      listRes.add(leaf);
    }
    return listRes;
  }

  static Future<Map<String, UnitCache<List<T>>>> _deserializeMapInfo<T>(
      List listIn, Future<List<T>> Function(List, String) func) async {
    Map<String, UnitCache<List<T>>> mapRes = {};
    for (dynamic element in listIn) {
      List el = element['Unit Cache']['Element'] == 'null'
          ? null
          : await func(element['Unit Cache']['Element'], element['Key']);
      int icon = element['Unit Cache']['Icon'] == 'null'
          ? null
          : int.parse(element['Unit Cache']['Icon']);
      mapRes[element['Key']] = UnitCache(
          el,
          DateTime.parse(element['Unit Cache']['Date']),
          element['Unit Cache']['Name'],
          icon);
    }
    return mapRes;
  }
}
