import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:provinciApp/model/cache.dart';

class SerializeCache {
  static Future<String> serialize(Cache cache) async {
    Map<String, dynamic> jsonMap = {};
    jsonMap['Organizations'] =
        await _serializeListNodeInfo(cache.organizations);
    jsonMap['Categories'] = await _serializeListNodeInfo(cache.categories);
    jsonMap['Last Search'] = cache.keyUltimiPacchetti;
    jsonMap['Last Leafs'] = cache.keyUltimeRisorse;
    jsonMap['Search'] =
        await _serializeMapInfo(cache.pacchetti, _serializeListNodeInfo);
    jsonMap['Leafs'] =
        await _serializeMapInfo(cache.risorse, _serializeListLeafInfo);
    return json.encode(jsonMap);
  }

  static Future<dynamic> _serializeListNodeInfo(dynamic listIn) async {
    List<Map> listRes = [];
    for (var e in listIn) {
      var element = await e;
      Map<String, dynamic> mapTmp = {
        'Name': element.nome,
        'Description': element.descrizione,
        'Url': element.url,
        'Image': element.immagineUrl
      };
      listRes.add(mapTmp);
    }
    return listRes;
  }

  static Future<dynamic> _serializeListLeafInfo(dynamic listIn) async {
    List<Map> listRes = [];
    for (var element in listIn) {
      Map<String, dynamic> mapTmp = {
        'Json': element.json,
        'Image File':
            element.immagineFile == null ? 'null' : element.immagineFile.path,
      };
      listRes.add(mapTmp);
    }
    return listRes;
  }

  static Future<dynamic> _serializeMapInfo(
      Map mapIn, Function(dynamic) func) async {
    List<Map> listRes = [];
    for (var element in mapIn.keys.toList()) {
      Map<String, dynamic> mapTmp = {
        'Key': element,
        'Unit Cache': {
          'Date': DateFormat('yyy-MM-dd HH:mm:ss').format(mapIn[element].data),
          'Name': mapIn[element].nome,
          'Icon': mapIn[element].icona.toString(),
          'Element': mapIn[element].elemento == null
              ? 'null'
              : await func(mapIn[element].elemento)
        }
      };
      listRes.add(mapTmp);
    }
    return listRes;
  }
}
