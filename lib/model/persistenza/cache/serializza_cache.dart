import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:provinciApp/model/cache/cache.dart';
import 'package:provinciApp/utility/costanti/costanti_cache.dart';
import 'package:provinciApp/utility/costanti/costanti_pacchetto.dart';
import 'package:provinciApp/utility/costanti/costanti_unitcache.dart';
import '../../../utility/costanti/costanti_risorsa.dart';

/// SerializzaCache permette tramite un metodo pubblico di serializzare una
/// cache in una stringa.
class SerializzzaCache {
  /// Metodo utile per serializzare una cache e ritornare la stringa serializzata.
  Future<String> serializza(Cache cache) async {
    Map<String, dynamic> jsonMap = {};
    jsonMap[CostantiCache.comuni] =
        await _serializzaListaPacchetti(cache.comuni);
    jsonMap[CostantiCache.categorie] =
        await _serializzaListaPacchetti(cache.categorie);
    jsonMap[CostantiCache.keyUltimiPacchetti] = cache.keyUltimiPacchetti;
    jsonMap[CostantiCache.keyUltimeRisorse] = cache.keyUltimeRisorse;
    jsonMap[CostantiCache.pacchetti] =
        await _serializzaUnitCache(cache.pacchetti, _serializzaListaPacchetti);
    jsonMap[CostantiCache.risorse] =
        await _serializzaUnitCache(cache.risorse, _serializzaListaRisorse);
    return json.encode(jsonMap);
  }

  /// Metodo utile per serializzare una lista di pacchetti.
  Future<dynamic> _serializzaListaPacchetti(dynamic listIn) async {
    List<Map> listRes = [];
    for (var e in listIn) {
      var element = await e;
      Map<String, dynamic> mapTmp = {
        CostantiPacchetto.nome: element.nome,
        CostantiPacchetto.descrizione: element.descrizione,
        CostantiPacchetto.url: element.url,
        CostantiPacchetto.immagineUrl: element.immagineUrl
      };
      listRes.add(mapTmp);
    }
    return listRes;
  }

  /// Metodo utile per serializzare una lista di risorse.
  Future<dynamic> _serializzaListaRisorse(dynamic listIn) async {
    List<Map> listRes = [];
    for (var element in listIn) {
      element.json[CostantiRisorsa.pathImmagine] =
          element.immagineFile == null ? 'null' : element.immagineFile.path;
      listRes.add(element.json);
    }
    return listRes;
  }

  /// Metodo utile per serializzare una lista di unità di cache.
  Future<dynamic> _serializzaUnitCache(
      Map mapIn, Function(dynamic) func) async {
    List<Map> listRes = [];
    for (var element in mapIn.entries) {
      Map<String, dynamic> mapTmp = {
        CostantiUnitCache.data:
            DateFormat('yyy-MM-dd HH:mm:ss').format(element.value.data),
        CostantiUnitCache.nome: element.value.nome,
        CostantiUnitCache.icona: element.value.icona.toString(),
        CostantiUnitCache.elemento: element.value.elemento == null
            ? 'null'
            : await func(element.value.elemento),
        CostantiUnitCache.id: element.key,
      };
      listRes.add(mapTmp);
    }
    return listRes;
  }
}
