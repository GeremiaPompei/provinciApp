import 'package:provinciApp/model/risorsa.dart';
import 'package:provinciApp/model/pacchetto.dart';
import 'unit_cache.dart';
import 'dart:developer';

/// Una Cache ha la responsabilità tener traccia e gestire la lista delle categorie,
/// la lista dei comuni, la lista delle risorse offline e le ultime ricerche sia
/// riguardanti i pacchetti che le risorse.
class Cache {
  /// Lista delle categorie.
  List<Future<Pacchetto>> _categorie;

  /// Lista dei comuni.
  List<Future<Pacchetto>> _comuni;

  /// Mappa che contiene le unità che inglobano gli ultimi pacchetti ricercati.
  Map<String, UnitCache<List<Pacchetto>>> _pacchetti;

  /// Mappa che contiene le unità che inglobano le ultime risorse ricercate.
  Map<String, UnitCache<List<Risorsa>>> _risorse;

  /// Lista delle risorse offline.
  List<Risorsa> _offline;

  /// Stringa rappresentante nella mappa dei pacchetti la chiave dell'ultima
  /// lista dei pacchetti ricercati.
  String _keyUltimiPacchetti;

  /// Stringa rappresentante nella mappa delle risorse la chiave dell'ultima
  /// lista delle risorse ricercate.
  String _keyUltimeRisorse;

  /// Costruttore della Cache che inizializza le variabili.
  Cache() {
    this._offline = [];
    this._categorie = [];
    this._comuni = [];
    this._pacchetti = {};
    this._risorse = {};
    _log('Costruita Cache.');
  }

  /// Metodo che inizializza la lista dei comuni.
  void initComuni(List<Future<Pacchetto>> pacchetti) {
    this._comuni = pacchetti;
    _log('Inizializzati comuni.');
  }

  /// Metodo che inizializza la lista delle categorie.
  void initCategorie(List<Future<Pacchetto>> pacchetti) {
    this._categorie = pacchetti;
    _log('Inizializzate categorie.');
  }

  /// Aggiunta risorsa alla lista delle risorse offline.
  void addOffline(Risorsa risorse) {
    this._offline.add(risorse);
    _log('Aggiunta risorsa alla lista delle risorse offline');
  }

  /// Rimossa risorsa dalla lista delle risorse offline.
  void removeOffline(Risorsa risorsa) {
    this._offline.remove(risorsa);
    _log('Rimossa risorsa dalla lista delle risorse offline');
  }

  /// Metodo per la sostituzione degli ultimi pacchetti con i nuovi.
  void switchPacchetti(
      String oldUrl, String newUrl, UnitCache<List<Pacchetto>> pacchetti) {
    this._pacchetti.remove(oldUrl);
    this._pacchetti[newUrl] = pacchetti;
    _log('Scambiati pacchetti.');
  }

  /// Metodo per la sostituzione delle ultime risorse con le nuove.
  void switchRisorse(
      String oldUrl, String newUrl, UnitCache<List<dynamic>> leafs) async {
    this._risorse.remove(oldUrl);
    this._risorse[newUrl] = leafs;
    _log('Scambiate risorse.');
  }

  /// Metodo che ritorna i pacchetti contenuti nell'unità di cache in base alla
  /// chiave nella mappa che corrisponde all'url per la loro ricerca.
  UnitCache<List<Pacchetto>> getPacchettiByKey(String url) =>
      this._pacchetti[url];

  /// Metodo che ritorna le risorse contenute nell'unità di cache in base alla
  /// chiave nella mappa che corrisponde all'url per la loro ricerca.
  UnitCache<List<Risorsa>> getRisorseByKey(String url) => this._risorse[url];

  /// Get della lista della chiave corrispondente alle ultime risorse visitate.
  String get keyUltimeRisorse => _keyUltimeRisorse;

  /// Get della lista della chiave corrispondente agli ultimi pacchetti visitati.
  String get keyUltimiPacchetti => _keyUltimiPacchetti;

  /// Get della lista delle risorse offline.
  List<Risorsa> get offline => _offline;

  /// Get della mappa delle ultime risorse ricercate.
  Map<String, UnitCache<List<Risorsa>>> get risorse => _risorse;

  /// Get della mappa degli ultimi pacchetti ricercati.
  Map<String, UnitCache<List<Pacchetto>>> get pacchetti => _pacchetti;

  /// Get della lista delle organizzazioni.
  List<Future<Pacchetto>> get organizations => _comuni;

  /// Get dela lista delle categorie.
  List<Future<Pacchetto>> get categories => _categorie;

  /// Set della mappa degli ultimi pacchetti visitati.
  set pacchetti(Map<String, UnitCache<List<Pacchetto>>> value) {
    _pacchetti = value;
  }

  /// Set della mappa delle ultime risorse visitate.
  set risorse(Map<String, UnitCache<List<Risorsa>>> value) {
    _risorse = value;
  }

  /// Set della chiave corrispondente agli ultimi pacchetti visitati nella
  /// mappa dei pacchetti.
  set keyUltimiPacchetti(String value) {
    _keyUltimiPacchetti = value;
  }

  /// Set della chiave corrispondente aglle ultime risorse visitate nella
  /// mappa delle risorse.
  set keyUltimeRisorse(String value) {
    _keyUltimeRisorse = value;
  }

  /// Set corrispondente alla lista delle risorse offline.
  set offline(List<Risorsa> value) {
    _offline = value;
  }

  /// Metodo privato utilizzato per la stampa dei messaggi di log.
  void _log(String messaggio) {
    log('[Cache] [' + DateTime.now().toString() + '] : ' + messaggio);
  }
}
