import 'dart:io';
import 'package:provinciApp/model/cache/cache.dart';
import 'package:provinciApp/model/persistenza/cache/deserializza_cache.dart';
import 'package:provinciApp/model/persistenza/cache/serializza_cache.dart';
import 'package:provinciApp/model/persistenza/offline/deserializza_offline.dart';
import 'package:provinciApp/model/persistenza/offline/serializza_offline.dart';
import 'package:provinciApp/model/persistenza/store_manager.dart';
import 'package:provinciApp/model/cache/unit_cache.dart';
import 'package:provinciApp/model/risorsa.dart';
import 'package:provinciApp/model/pacchetto.dart';
import 'package:provinciApp/model/web/http_request.dart';

class Controller {
  Cache _cache;
  List<Pacchetto> _events;
  List<Pacchetto> _promos;
  HttpRequest _httpRequest;
  StoreManager _storeManager;
  SerializzzaCache _serializeCache;
  DeserializzaCache _deserializeCache;
  SerializzaOffline _serializeOffline;
  DeserializzaOffline _deserializeOffline;
  static const FNCACHE = 'cache.json';
  static const FNOFFLINE = 'offline.json';
  static const DNIMAGE = 'Image';

  Controller() {
    _events = [];
    _promos = [];
    _cache = new Cache();
    _httpRequest = new HttpRequest();
    _storeManager = new StoreManager();
    _serializeCache = new SerializzzaCache();
    _deserializeCache = new DeserializzaCache();
    _serializeOffline = new SerializzaOffline();
    _deserializeOffline = new DeserializzaOffline();
  }

  Future<bool> tryConnection() async {
    final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  }

  Future<dynamic> initLoadAndStore() async {
    if (this._cache.keyUltimeRisorse == null) {
      //(await _storeManager.getFile(FNCACHE)).deleteSync();
      if (!(await _storeManager.getFile(FNCACHE)).existsSync()) {
        _loadStaticLastInfo(4, 4);
        this._cache.initComuni(await _httpRequest.cercaComuni());
        this._cache.initCategorie(await _httpRequest.cercaCategorie());
      } else {
        await _loadCacheOffline();
        _loadCache();
      }
      await initOffline();
      _storeCache();
      _storeOffline();
    }
    return this._cache;
  }

  Future<dynamic> _loadCache() async {
    try {
      var loaded = await _storeManager.leggiFile(FNCACHE);
      Cache tmpCache = await _deserializeCache.deserializza(loaded);
      await _loadLastInfoFrom(tmpCache);
    } catch (e) {}
    return this._cache;
  }

  Future<dynamic> _loadLastInfoFrom(Cache tmpCache) async {
    this._cache.pacchetti = tmpCache.pacchetti;
    for (MapEntry<String, dynamic> entry in this._cache.pacchetti.entries) {
      if (!entry.key.contains('Empty'))
        entry.value.elemento = await _httpRequest.cercaPacchetto(entry.key);
    }
    this._cache.keyUltimiPacchetti = tmpCache.keyUltimiPacchetti;
    this._cache.risorse = tmpCache.risorse;
    for (MapEntry<String, dynamic> entry in this._cache.risorse.entries) {
      if (!entry.key.contains('Empty')) {
        entry.value.elemento = await _httpRequest.cercaRisorsa(entry.key);
        for (Risorsa leaf in entry.value.elemento) await _saveImage(leaf);
      }
    }
    this._cache.keyUltimeRisorse = tmpCache.keyUltimeRisorse;
    return tmpCache.keyUltimeRisorse;
  }

  Future<dynamic> _loadCacheOffline() async {
    this._cache =
        await _deserializeCache.deserializza(await _storeManager.leggiFile(FNCACHE));
    return this._cache;
  }

  void _loadStaticLastInfo(int countNodes, int countLeafs) {
    for (int i = countNodes - 1; i >= 0; i--)
      this._cache.pacchetti['Empty $i'] = UnitCache(
          null, DateTime.now().subtract(Duration(days: 5)), 'Name', null);
    for (int i = 0; i < countLeafs; i++)
      this._cache.risorse['Empty $i'] = UnitCache(
          null, DateTime.now().subtract(Duration(days: 5)), 'Name', null);
  }

  Future<dynamic> initCategories() async {
    if (this.getCategories().isEmpty) {
      try {
        List<Future> list = await _httpRequest.cercaCategorie();
        this._cache.initCategorie(list);
      } catch (e) {
        Cache tmpCache = await _deserializeCache.deserializza(
            await _storeManager.leggiFile(FNCACHE));
        this._cache.initCategorie(tmpCache.categorie);
      }
    }
    _storeCache();
    return this.getCategories();
  }

  Future<dynamic> initOrganizations() async {
    if (this.getOrganizations().isEmpty) {
      try {
        List<Future> list = await _httpRequest.cercaComuni();
        this._cache.initComuni(list);
      } catch (e) {
        Cache tmpCache = await _deserializeCache.deserializza(
            await _storeManager.leggiFile(FNCACHE));
        this._cache.initComuni(tmpCache.comuni);
      }
    }
    _storeCache();
    return this.getOrganizations();
  }

  Future<dynamic> initOffline() async {
    await _loadOffline();
    try {
      for (var el in this._cache.offline) {
        List<Risorsa> list = await _httpRequest.cercaRisorsa(el.idUrl);
        await _saveImage(list[el.idIndice]);
        el = list[el.idIndice];
      }
    } catch (e) {}
    return getOffline();
  }

  Future<dynamic> setSearch(String name, String url, int image) async {
    UnitCache<List<Pacchetto>> cacheUnit = this._cache.getPacchettiByKey(url);
    if (cacheUnit == null) {
      List<Pacchetto> nodes = await _httpRequest.cercaPacchetto(url);
      if (nodes.isNotEmpty) {
        String oldUrl = _oldestUrl(
            this._cache.pacchetti.keys, (el) => this._cache.getPacchettiByKey(el));
        cacheUnit = this._cache.pacchetti[oldUrl];
        cacheUnit.nome = name;
        cacheUnit.elemento = nodes;
        cacheUnit.icona = image;
        this._cache.switchPacchetti(oldUrl, url, cacheUnit);
        cacheUnit.updateDate();
        _storeCache();
      } else
        return [];
    } else
      cacheUnit.updateDate();
    this._cache.keyUltimiPacchetti = url;
    return getSearch();
  }

  Future<List<dynamic>> setLeafInfo(String name, String url, int image) async {
    UnitCache<List<Risorsa>> cacheUnit = this._cache.getRisorseByKey(url);
    if (cacheUnit == null) {
      List<Risorsa> leafs = await _httpRequest.cercaRisorsa(url);
      if (leafs.isNotEmpty) {
        String oldUrl = _oldestUrl(
            this._cache.risorse.keys, (el) => this._cache.getRisorseByKey(el));
        cacheUnit = this._cache.risorse[oldUrl];
        cacheUnit.nome = name;
        cacheUnit.icona = image;
        var tmp = cacheUnit.elemento;
        cacheUnit.elemento = leafs;
        if (tmp != null)
          for (Risorsa leaf in tmp) await this._removeImage(leaf);
        for (Risorsa leaf in cacheUnit.elemento) await this._saveImage(leaf);
        this._cache.switchRisorse(oldUrl, url, cacheUnit);
      } else
        return [];
    }
    cacheUnit.updateDate();
    _storeCache();
    this._cache.keyUltimeRisorse = url;
    return getLeafs();
  }

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

  Future<dynamic> addOffline(Risorsa leafInfo) async {
    this._cache.addOffline(leafInfo);
    await _saveImage(leafInfo);
    _storeOffline();
    return this.getOffline();
  }

  void removeOffline(Risorsa leafInfo) async {
    this._cache.removeOffline(leafInfo);
    await _removeImage(leafInfo);
    _storeOffline();
  }

  List<Pacchetto> getEvents() {
    return this._events;
  }

  List<Pacchetto> getPromos() {
    return this._promos;
  }

  List<Future<Pacchetto>> getOrganizations() {
    return this._cache.comuni;
  }

  List<Future<Pacchetto>> getCategories() {
    return this._cache.categorie;
  }

  List<Pacchetto> getSearch() {
    return this._cache.getPacchettiByKey(this._cache.keyUltimiPacchetti).elemento;
  }

  List<MapEntry<String, dynamic>> getLastSearched() =>
      this._cache.pacchetti.entries.toList();

  List<MapEntry<String, dynamic>> getLastLeafs() =>
      this._cache.risorse.entries.toList();

  List<Risorsa> getLeafs() {
    return this._cache.getRisorseByKey(this._cache.keyUltimeRisorse).elemento;
  }

  List<Risorsa> getOffline() => this._cache.offline;

  Future _storeCache() async {
    return _storeManager.scriviFile(
        await _serializeCache.serializza(this._cache), FNCACHE);
  }

  Future _storeOffline() async {
    return await _storeManager.scriviFile(
        _serializeOffline.serializza(this._cache.offline), FNOFFLINE);
  }

  Future _loadOffline() async {
    try {
      this._cache.offline = await _deserializeOffline.deserializza(
          await _storeManager.leggiFile(FNOFFLINE));
    } catch (e) {}
  }

  Future<dynamic> _saveImage(Risorsa leafInfo) async {
    if (!(await _storeManager.getDirectory(DNIMAGE)).existsSync())
      (await _storeManager.getDirectory(DNIMAGE)).createSync();
    var byte;
    try {
      if (leafInfo.immagineUrl != null) {
        String path =
            leafInfo.immagineUrl.substring(leafInfo.immagineUrl.lastIndexOf('/') + 1);
        leafInfo.immagineFile = await _storeManager.getFile(DNIMAGE + '/' + path);
        byte = await _httpRequest.cercaImmagine(leafInfo.immagineUrl);
        _storeManager.scriviBytes(byte, leafInfo.immagineFile.path);
      }
    } catch (e) {}
    return byte;
  }

  Future<dynamic> _removeImage(Risorsa leafInfo) async {
    List list = [];
    list.addAll(this._cache.offline);
    this._cache.risorse.values.map((e) => e.elemento).forEach((element) {
      if (element != null) list.addAll(element);
    });
    if (leafInfo.immagineFile != null) {
      var file = await _storeManager.getFile(leafInfo.immagineFile.path);
      if (!list.map((e) => e.immagineFile).contains(leafInfo.immagineFile))
        file.deleteSync();
    }
    return list;
  }
}
