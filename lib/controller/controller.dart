import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:provinciApp/model/costanti/costanti_nomefile.dart';
import 'package:provinciApp/model/costanti/costanti_unitcache.dart';
import 'package:provinciApp/model/cache/cache.dart';
import 'package:provinciApp/model/persistenza/cache/deserializza_cache.dart';
import 'package:provinciApp/model/persistenza/cache/serializza_cache.dart';
import 'package:provinciApp/model/persistenza/offline/deserializza_offline.dart';
import 'package:provinciApp/model/persistenza/offline/serializza_offline.dart';
import 'package:provinciApp/model/persistenza/store_manager.dart';
import 'package:provinciApp/model/cache/unit_cache.dart';
import 'package:provinciApp/model/risorsa.dart';
import 'package:provinciApp/model/pacchetto.dart';
import 'package:provinciApp/model/costanti/costanti_web.dart';
import 'package:provinciApp/model/web/http_request.dart';

/// Un Controller non è altro che il controller dell'MVC che sei occupa di
/// fornire alla view le funzioni per accedere al backend e reperire le
/// informazioni necessarie.
class Controller {
  /// Cache del controller, essa è l'elemento che memorizza i vari dati.
  Cache _cache;

  /// Attributo che permette di fare chiamate rest tramite la rete.
  HttpRequest _httpRequest;

  /// Attributo che permette di accedere e manipolare il filesystem leggendo e
  /// scrivendo.
  StoreManager _storeManager;

  /// Attributo che permette di serializzare la cache in stringa.
  SerializzzaCache _serializeCache;

  /// Attributo che permette di deserializzare una stringa in cache.
  DeserializzaCache _deserializeCache;

  /// Attributo che permette di serializzare una lista di risorse in stringa.
  SerializzaOffline _serializeOffline;

  /// Attributo che permette di deserializzare una stringa in lista di risorse.
  DeserializzaOffline _deserializeOffline;

  /// Attributo che pèermette di tener traccia dei Pacchetti extra.
  List<Pacchetto> _extra;

  /// Costruttore del controller che inizializza le varie variabili.
  Controller() {
    _cache = new Cache();
    _httpRequest = new HttpRequest();
    _storeManager = new StoreManager();
    _serializeCache = new SerializzzaCache();
    _deserializeCache = new DeserializzaCache();
    _serializeOffline = new SerializzaOffline();
    _deserializeOffline = new DeserializzaOffline();
    _extra = [];
  }

  /// Metodo utile per inizializzare il controller caricando i dati iniziali.
  Future<dynamic> initController() async {
    if (this._cache.keyUltimeRisorse == null) {
      if (!(await _storeManager.getFile(CostantiNomeFile.cache)).existsSync()) {
        _initUnitCache(4, 4);
        this._cache.initComuni(await _httpRequest.cercaComuni());
        this._cache.initCategorie(await _httpRequest.cercaCategorie());
      } else {
        this._cache = await _leggiCacheDaFile();
      }
      await initOffline();
      await initExtra();
      _scriviCache();
      _scriviOffline();
    }
    return this._cache;
  }

  /// Metodo utile per caricare gli ultimi dati elaborati in cache da un file
  /// locale.
  Future<dynamic> _leggiCacheDaFile() async {
    String loaded = await _storeManager.leggiFile(CostantiNomeFile.cache);
    Cache tmpCache = await _deserializeCache.deserializza(loaded);
    _aggiornaCacheLettaDaFile(tmpCache).catchError((e) => null);
    return tmpCache;
  }

  /// Metodo utile per aggiornare i dati della cache caricati localmente.
  Future<dynamic> _aggiornaCacheLettaDaFile(Cache tmpCache) async {
    this._cache.pacchetti = tmpCache.pacchetti;
    for (MapEntry<String, dynamic> entry in this._cache.pacchetti.entries) {
      if (!entry.key.contains(CostantiUnitCache.idVuoto))
        entry.value.elemento = await _httpRequest.cercaPacchetto(entry.key);
    }
    this._cache.keyUltimiPacchetti = tmpCache.keyUltimiPacchetti;
    this._cache.risorse = tmpCache.risorse;
    for (MapEntry<String, dynamic> entry in this._cache.risorse.entries) {
      if (!entry.key.contains(CostantiUnitCache.idVuoto)) {
        entry.value.elemento = await _httpRequest.cercaRisorsa(entry.key);
        for (Risorsa risorsa in entry.value.elemento)
          await _salvaImmagine(risorsa);
      }
    }
    this._cache.keyUltimeRisorse = tmpCache.keyUltimeRisorse;
    return tmpCache.keyUltimeRisorse;
  }

  /// Metodo utile per inizializzare le unità di cache della cache con dati
  /// vuoti immessi per la sostituzione.
  void _initUnitCache(int countPacchetti, int countRisorse) {
    for (int i = countPacchetti - 1; i >= 0; i--) {
      this._cache.pacchetti[CostantiUnitCache.idVuoto + ' $i'] = UnitCache([],
          DateTime.now().subtract(Duration(days: 5)),
          CostantiUnitCache.nomeVuoto,
          null);
      this._cache.keyUltimiPacchetti = CostantiUnitCache.idVuoto + ' $i';
    }
    for (int i = countRisorse - 1; i >= 0; i--) {
      this._cache.risorse[CostantiUnitCache.idVuoto + ' $i'] = UnitCache([],
          DateTime.now().subtract(Duration(days: 5)),
          CostantiUnitCache.nomeVuoto,
          null);
      this._cache.keyUltimeRisorse = CostantiUnitCache.idVuoto + ' $i';
    }
  }

  /// Metodo utile per inizializzare i comuni.
  Future<dynamic> initComuni() async {
    if (this.comuni.isEmpty) {
      try {
        List<Future> list = await _httpRequest.cercaComuni();
        this._cache.initComuni(list);
      } catch (e) {
        Cache tmpCache = await _deserializeCache.deserializza(
            await _storeManager.leggiFile(CostantiNomeFile.cache));
        this._cache.initComuni(tmpCache.comuni);
      }
    }
    _scriviCache();
    initExtra();
    return this.comuni;
  }

  /// Metodo utile per inizializzare le categorie.
  Future<dynamic> initCategorie() async {
    if (this.categorie.isEmpty) {
      try {
        List<Future> list = await _httpRequest.cercaCategorie();
        this._cache.initCategorie(list);
      } catch (e) {
        Cache tmpCache = await _deserializeCache.deserializza(
            await _storeManager.leggiFile(CostantiNomeFile.cache));
        this._cache.initCategorie(tmpCache.categorie);
      }
    }
    _scriviCache();
    initExtra();
    return this.categorie;
  }

  /// Metodo utile per inizializzare le risorse scaricate offline.
  Future<dynamic> initOffline() async {
    await _leggiOffline();
    try {
      for (var el in this._cache.offline) {
        List<Risorsa> list = await _httpRequest.cercaRisorsa(el.idUrl);
        await _salvaImmagine(list[el.idIndice]);
        el = list[el.idIndice];
      }
    } catch (e) {}
    initExtra();
    return offline;
  }

  /// Metodo utile per inizializzare i pacchetti extra.
  Future<dynamic> initExtra() async {
    try {
      this._extra = await this._httpRequest.getExtra();
    } catch (e) {
      this._extra = [];
    }
  }

  /// Metodo utile per la posizione locale.
  Future<String> cercaPosizione() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    Position position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    List<Placemark> placemark =
        await geolocator.placemarkFromPosition(position);
    String location = placemark[0].locality;
    return location;
  }

  /// Metodo utile per cercare pacchetti in base ad una parola chiave.
  Future<List<dynamic>> cercaFromParola(String name, int image) async =>
      await cercaFromUrl(name, CostantiWeb.urlProvinciaSearch + name, image);

  /// Metodo utile per cercare pacchetti in base ad un url.
  Future<dynamic> cercaFromUrl(String name, String url, int image) async {
    UnitCache<List<Pacchetto>> cacheUnit = this._cache.getPacchettiByKey(url);
    if (cacheUnit == null) {
      List<Pacchetto> pacchetti = await _httpRequest.cercaPacchetto(url);
      if (pacchetti.isNotEmpty) {
        String oldUrl = _oldestUrl(
            this._cache.pacchetti.keys, this._cache.getPacchettiByKey);
        cacheUnit = this._cache.pacchetti[oldUrl];
        cacheUnit.nome = name;
        cacheUnit.elemento = pacchetti;
        cacheUnit.icona = image;
        this._cache.switchPacchetti(oldUrl, url, cacheUnit);
        cacheUnit.updateDate();
        _scriviCache();
      } else
        return [];
    } else
      cacheUnit.updateDate();
    this._cache.keyUltimiPacchetti = url;
    return ultimiPacchetti;
  }

  /// Metodo utile per cercare risorse in base ad un url.
  Future<List<dynamic>> cercaRisorse(String name, String url, int image) async {
    UnitCache<List<Risorsa>> cacheUnit = this._cache.getRisorseByKey(url);
    if (cacheUnit == null) {
      List<Risorsa> risorse = await _httpRequest.cercaRisorsa(url);
      if (risorse.isNotEmpty) {
        String oldUrl =
            _oldestUrl(this._cache.risorse.keys, this._cache.getRisorseByKey);
        cacheUnit = this._cache.risorse[oldUrl];
        cacheUnit.nome = name;
        cacheUnit.icona = image;
        var tmp = cacheUnit.elemento;
        cacheUnit.elemento = risorse;
        if (tmp != null)
          for (Risorsa risorsa in tmp) await this._rimuoviImmagine(risorsa);
        for (Risorsa risorsa in cacheUnit.elemento)
          await this._salvaImmagine(risorsa);
        this._cache.switchRisorse(oldUrl, url, cacheUnit);
      } else
        return [];
    }
    cacheUnit.updateDate();
    _scriviCache();
    this._cache.keyUltimeRisorse = url;
    return ultimeRisorse;
  }

  /// Metodo privato utile a cercare in una lista l'elemento memorizzato più in
  /// la nel tempo.
  String _oldestUrl(Iterable<String> list, UnitCache Function(String) func) {
    String oldUrl;
    DateTime tmpDate;
    list.forEach((el) => {
          if (tmpDate == null || tmpDate.isAfter(func(el).data))
            {
              tmpDate = func(el).data,
              oldUrl = el,
            }
        });
    return oldUrl;
  }

  /// Metodo utile a scaricare una risorsa offline.
  Future<dynamic> addOffline(Risorsa risorsa) async {
    this._cache.addOffline(risorsa);
    await _salvaImmagine(risorsa);
    _scriviOffline();
    return this.offline;
  }

  /// Metodo utile a rimuovere una risorsa gia scaricata offline.
  void removeOffline(Risorsa risorsa) async {
    this._cache.removeOffline(risorsa);
    await _rimuoviImmagine(risorsa);
    _scriviOffline();
  }

  /// Metodo privato utile per salvare la cache del controller su file locale.
  Future _scriviCache() async => _storeManager.scriviFile(
      await _serializeCache.serializza(this._cache), CostantiNomeFile.cache);

  /// Metodo privato utile per salvare la lista di risorse scaricate offline
  /// del controller su file locale.
  Future _scriviOffline() async {
    return await _storeManager.scriviFile(
        _serializeOffline.serializza(this._cache.offline),
        CostantiNomeFile.offline);
  }

  /// Metodo privato utile per leggere la lista delle risorse scaricate offline
  /// del controller da file locale.
  Future _leggiOffline() async {
    try {
      this._cache.offline = await _deserializeOffline.deserializza(
          await _storeManager.leggiFile(CostantiNomeFile.offline));
    } catch (e) {}
  }

  /// Metodo privato utile a salvare l'immagine della risorsa data in locale.
  Future<dynamic> _salvaImmagine(Risorsa risorsa) async {
    if (!(await _storeManager.getDirectory(CostantiNomeFile.immagini))
        .existsSync())
      (await _storeManager.getDirectory(CostantiNomeFile.immagini))
          .createSync();
    var byte;
    try {
      if (risorsa.immagineUrl != null) {
        String path = risorsa.immagineUrl
            .substring(risorsa.immagineUrl.lastIndexOf('/') + 1);
        risorsa.immagineFile =
            await _storeManager.getFile(CostantiNomeFile.immagini + '/' + path);
        byte = await _httpRequest.cercaImmagine(risorsa.immagineUrl);
        _storeManager.scriviBytes(byte, risorsa.immagineFile.path);
      }
    } catch (e) {}
    return byte;
  }

  /// Metodo privato utile a rimuovere l'immagine della risorsa data dalle
  /// immagini salvate in locale.
  Future<dynamic> _rimuoviImmagine(Risorsa risorsa) async {
    List list = [];
    list.addAll(this._cache.offline);
    this._cache.risorse.values.map((e) => e.elemento).forEach((element) {
      if (element != null) list.addAll(element);
    });
    if (risorsa.immagineFile != null) {
      var file = await _storeManager.getFile(risorsa.immagineFile.path);
      if (!list.map((e) => e.immagineFile).contains(risorsa.immagineFile))
        file.deleteSync();
    }
    return list;
  }

  /// Metodo che fornisce i pacchetti degli extra.
  List<Pacchetto> get extra => this._extra;

  List<Future<Pacchetto>> get comuni => this._cache.comuni;

  List<Future<Pacchetto>> get categorie => this._cache.categorie;

  List<Pacchetto> get ultimiPacchetti =>
      this._cache.getPacchettiByKey(this._cache.keyUltimiPacchetti).elemento;

  List<Risorsa> get ultimeRisorse =>
      this._cache.getRisorseByKey(this._cache.keyUltimeRisorse).elemento;

  List<MapEntry<String, dynamic>> get pacchetti =>
      this._cache.pacchetti.entries.toList();

  List<MapEntry<String, dynamic>> get risorse =>
      this._cache.risorse.entries.toList();

  List<Risorsa> get offline => this._cache.offline;
}
