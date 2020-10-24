import 'dart:convert';
import 'package:provinciApp/model/persistence/store_manager.dart';
import '../../cache/cache.dart';
import '../../risorsa.dart';
import '../../pacchetto.dart';
import '../../cache/unit_cache.dart';
import 'costanti_cache.dart';
import 'costanti_pacchetto.dart';
import 'costanti_risorsa.dart';
import 'costanti_unit_cache.dart';

/// DeserializzaCache permette tramite un metodo pubblico di deserializzare una
/// stringa in una cache.
class DeserializzaCache {
  /// Metodo utile per deserializzare una stringa in una cache.
  Future<Cache> deserializza(String contents) async {
    Map<String, dynamic> jsonMap = json.decode(contents);
    Cache cache = new Cache();
    cache.initComuni(
        (await _deserializzaListaPacchetti(jsonMap[CostantiCache.comuni]))
            .map((e) async => e)
            .toList());
    cache.initCategorie(
        (await _deserializzaListaPacchetti(jsonMap[CostantiCache.categorie]))
            .map((e) async => e)
            .toList());
    cache.keyUltimiPacchetti = jsonMap[CostantiCache.keyUltimiPacchetti];
    cache.keyUltimeRisorse = jsonMap[CostantiCache.keyUltimeRisorse];
    cache.pacchetti = await _deserializzaUnitCache(
        jsonMap[CostantiCache.pacchetti],
        (el, s) async => await _deserializzaListaPacchetti(el));
    cache.risorse = await _deserializzaUnitCache(jsonMap[CostantiCache.risorse],
        (el, s) async => await _deserializzaListaRisorse(el, s));
    return cache;
  }

  /// Metodo utile per deserializzare una lista di stringhe in lista di
  /// pacchetti.
  Future<List<Pacchetto>> _deserializzaListaPacchetti(List listIn) async {
    List<Pacchetto> listRes = [];
    listIn.forEach((element) {
      listRes.add(Pacchetto(
          element[CostantiPacchetto.nome],
          element[CostantiPacchetto.descrizione],
          element[CostantiPacchetto.url],
          immagineUrl: element[CostantiPacchetto.immagineUrl]));
    });
    return listRes;
  }

  /// Metodo utile per deserializzare una lista di stringhe in lista di risorse.
  Future<List<Risorsa>> _deserializzaListaRisorse(
      List listIn, String url) async {
    StoreManager _storeManager = new StoreManager();
    List<Risorsa> listRes = [];
    for (int i = 0; i < listIn.length; i++) {
      Risorsa risorsa = Risorsa(listIn[i][CostantiRisorsa.json], url, i);
      if (listIn[i][CostantiRisorsa.pathImmagine] != 'null')
        risorsa.immagineFile = await _storeManager
            .getFile(listIn[i][CostantiRisorsa.pathImmagine]);
      listRes.add(risorsa);
    }
    return listRes;
  }

  /// Metodo utile per deserializzare una lista din stringhe in lista di unità
  /// di cache.
  Future<Map<String, UnitCache<List<T>>>> _deserializzaUnitCache<T>(
      List listIn, Future<List<T>> Function(List, String) func) async {
    Map<String, UnitCache<List<T>>> mapRes = {};
    for (dynamic element in listIn) {
      List el = element[CostantiUnitCache.unitCache]
                  [CostantiUnitCache.elemento] ==
              'null'
          ? null
          : await func(
              element[CostantiUnitCache.unitCache][CostantiUnitCache.elemento],
              element[CostantiUnitCache.chiave]);
      int icon = element[CostantiUnitCache.unitCache]
                  [CostantiUnitCache.icona] ==
              'null'
          ? null
          : int.parse(
              element[CostantiUnitCache.unitCache][CostantiUnitCache.icona]);
      mapRes[element[CostantiUnitCache.chiave]] = UnitCache(
          el,
          DateTime.parse(
              element[CostantiUnitCache.unitCache][CostantiUnitCache.data]),
          element[CostantiUnitCache.unitCache][CostantiUnitCache.nome],
          icon);
    }
    return mapRes;
  }
}
