import 'dart:convert';
import 'package:provinciApp/model/persistence/offline/costanti_offline.dart';

import '../../risorsa.dart';

/// SerializzaOffline permette tramite un metodo pubblico di serializzare una
/// lista di risorse in una stringa.
class SerializzaOffline {
  /// Metodo che permette la serializzazione di una lista di risorse e ritorna
  /// una stringa.
  String serializza(List<Risorsa> risorse) {
    List<Map<String, dynamic>> listMap = [];
    risorse.forEach((element) {
      Map<String, dynamic> jsonMap = {
        CostantiOffline.idUrl: element.idUrl,
        CostantiOffline.idIndice: element.idIndice.toString(),
        CostantiOffline.listaElementi: element.json,
        CostantiOffline.pathImmagine:
            element.immagineFile == null ? '' : element.immagineFile.path,
      };
      listMap.add(jsonMap);
    });
    return json.encode(listMap);
  }
}
