import 'dart:convert';
import 'dart:io';
import 'package:provinciApp/model/persistenza/offline/costanti_offline.dart';
import 'package:provinciApp/model/risorsa.dart';
import 'package:provinciApp/model/persistenza/store_manager.dart';
import 'package:provinciApp/model/web/http_request.dart';

/// DeserializzaOffline permette tramite un metodo pubblico di deserializzare
/// una stringa in una lista di risorse.
class DeserializzaOffline {
  /// Metodo utile per deserializzare una stringa din una lista di risorse.
  Future<List<Risorsa>> deserializza(String contents) async {
    List<Risorsa> listRes = [];
    List<dynamic> listIn = json.decode(contents);
    for (var element in listIn) {
      Risorsa risorsa = Risorsa(element[CostantiOffline.listaElementi],
          CostantiOffline.idUrl, int.parse(element[CostantiOffline.idIndice]));
      await _deserializzaImmagine(
          element[CostantiOffline.pathImmagine], risorsa);
      listRes.add(risorsa);
    }
    return listRes;
  }

  /// Metodo utile per deserializzare un'immagine dati il path e una risorsa.
  Future<dynamic> _deserializzaImmagine(
      String pathImmagine, Risorsa risorsa) async {
    StoreManager _storeManager = new StoreManager();
    if (pathImmagine != '') {
      try {
        List<int> content =
            await HttpRequest().cercaImmagine(risorsa.immagineUrl);
        File file = await _storeManager.getFile(pathImmagine);
        file.delete();
        _storeManager.scriviBytes(content, file.path);
        risorsa.immagineFile = file;
      } catch (e) {
        risorsa.immagineFile = await _storeManager.getFile(pathImmagine);
      }
    } else
      risorsa.immagineFile = null;
    return risorsa.immagineFile;
  }
}
