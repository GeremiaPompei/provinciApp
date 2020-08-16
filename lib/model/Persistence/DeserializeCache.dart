import 'dart:convert';

import 'package:MC/model/LeafsInfo/Suap.dart';

import '../Cache.dart';
import '../LeafInfo.dart';
import '../LeafsInfo/AreeCamper.dart';
import '../LeafsInfo/Bando.dart';
import '../LeafsInfo/Biblioteca.dart';
import '../LeafsInfo/Concorso.dart';
import '../LeafsInfo/Evento.dart';
import '../LeafsInfo/Monumento.dart';
import '../LeafsInfo/Museo.dart';
import '../LeafsInfo/Shopping.dart';
import '../LeafsInfo/Struttura.dart';
import '../LeafsInfo/Teatro.dart';
import '../NodeInfo.dart';
import '../UnitCache.dart';

class DeserializeCache{
  static Cache deserialize(String contents) {
    Map<String, dynamic> jsonMap = json.decode(contents);
    Cache cache = Cache(int.parse(jsonMap['Search Count']),int.parse(jsonMap['Leafs Count']));
    cache.setLastSearch(jsonMap['Last Search']);
    cache.setLastLeafs(jsonMap['Last Leafs']);
    cache.initOrganizations(deserializeNodeListInfo(jsonMap['Organizations']));
    cache.initCategories(deserializeNodeListInfo(jsonMap['Categories']));
    cache.setSearch(deserializeMapInfo(jsonMap['Search'],(el)=>deserializeNodeListInfo(el)));
    cache.setLeafs(deserializeMapInfo(jsonMap['Leafs'],(el)=>deserializeLeafListInfo(el)));
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

  static List<LeafInfo> deserializeLeafListInfo(List listIn) {
    List<LeafInfo> listRes = [];
    listIn.forEach((element) {
      switch (element['Type']) {
        case 'AreeCamper':
          listRes.add(AreeCamper.fromJson(element['Json']));
          break;
        case 'Bando':
          listRes.add(Bando.fromJson(element['Json']));
          break;
        case 'Biblioteca':
          listRes.add(Biblioteca.fromJson(element['Json']));
          break;
        case 'Concorso':
          listRes.add(Concorso.fromJson(element['Json']));
          break;
        case 'Evento':
          listRes.add(Evento.fromJson(element['Json']));
          break;
        case 'Monumento':
          listRes.add(Monumento.fromJson(element['Json']));
          break;
        case 'Museo':
          listRes.add(Museo.fromJson(element['Json']));
          break;
        case 'Shopping':
          listRes.add(Shopping.fromJson(element['Json']));
          break;
        case 'Struttura':
          listRes.add(Struttura.fromJson(element['Json']));
          break;
        case 'Teatro':
          listRes.add(Teatro.fromJson(element['Json']));
          break;
        case 'Suap':
          listRes.add(Suap.fromJson(element['Json']));
          break;
      }
    });
    return listRes;
  }

  static Map<String, UnitCache<List<T>>> deserializeMapInfo<T>(
      List listIn,List<T> Function(List) func) {
    Map<String, UnitCache<List<T>>> mapRes = {};
    listIn.forEach((element) {
      List el = func(element['Unit Cache']['Elements']);
      mapRes[element['Key']] =
          UnitCache(el, DateTime.parse(element['Unit Cache']['Date']));
    });
    return mapRes;
  }
}