import 'dart:convert';
import 'package:provinciApp/model/persistenza/store_manager.dart';
import '../../cache/cache.dart';
import '../../../utility/costanti/costanti_risorsa.dart';
import '../../risorsa.dart';
import '../../pacchetto.dart';
import '../../cache/unit_cache.dart';
import '../../../utility/costanti/costanti_cache.dart';
import '../../../utility/costanti/costanti_pacchetto.dart';
import '../../../utility/costanti/costanti_unitcache.dart';

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
    cache.risorse = await _deserializzaUnitCache(
        jsonMap[CostantiCache.risorse], _deserializzaListaRisorse);
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
      Risorsa risorsa = Risorsa(listIn[i], url, i);
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
      List el = element[CostantiUnitCache.elemento] == 'null'
          ? null
          : await func(element[CostantiUnitCache.elemento],
              element[CostantiUnitCache.id]);
      int icon = element[CostantiUnitCache.icona] == 'null'
          ? null
          : int.parse(element[CostantiUnitCache.icona]);
      mapRes[element[CostantiUnitCache.id]] = UnitCache(
          el,
          DateTime.parse(element[CostantiUnitCache.data]),
          element[CostantiUnitCache.nome],
          icon);
    }
    return mapRes;
  }
}
