import 'dart:convert';
import 'package:MC/model/Persistence/StoreManager.dart';

import '../Cache.dart';
import '../LeafInfo.dart';
import '../NodeInfo.dart';
import '../UnitCache.dart';

class DeserializeCache {
  static Future<Cache> deserialize(String contents) async {
    Map<String, dynamic> jsonMap = json.decode(contents);
    Cache cache = Cache();
    cache.initOrganizations(
        (await _deserializeNodeListInfo(jsonMap['Organizations']))
            .map((e) async => e)
            .toList());
    cache.initCategories((await _deserializeNodeListInfo(jsonMap['Categories']))
        .map((e) async => e)
        .toList());
    cache.lastSearch = jsonMap['Last Search'];
    cache.lastLeafs = jsonMap['Last Leafs'];
    cache.search = await _deserializeMapInfo(
        jsonMap['Search'], (el, s) async => await _deserializeNodeListInfo(el));
    cache.leafs = await _deserializeMapInfo(jsonMap['Leafs'],
        (el, s) async => await _deserializeLeafListInfo(el, s));
    return cache;
  }

  static Future<List<NodeInfo>> _deserializeNodeListInfo(List listIn) async {
    List<NodeInfo> listRes = [];
    listIn.forEach((element) {
      listRes.add(NodeInfo(element['Name'], element['Description'],
          element['Url'], element['Image']));
    });
    return listRes;
  }

  static Future<List<LeafInfo>> _deserializeLeafListInfo(
      List listIn, String url) async {
    List<LeafInfo> listRes = [];
    for (int i = 0; i < listIn.length; i++) {
      LeafInfo leaf = LeafInfo(listIn[i]['Json'], url, i);
      if (listIn[i]['Image File'] != 'null')
        leaf.imageFile = await StoreManager.localFile(listIn[i]['Image File']);
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
