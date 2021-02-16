import 'dart:io';
import 'dart:developer';
import 'package:provinciApp/model/utility_risorsa.dart';

/// Una Risorsa è un elemento del sistema identificato univocamente da un url e
/// un indice ed ha come attributi un nome, una descrizione, un url, un url di
/// un immagine, un file corrispondente all'immagine scaricata in locale, dei
/// numeri di telefono, una mail, una posizione identificata da due double e
/// una serie di informazioni aggiuntive. Una risorsa tiene traccia anche della
/// mappa json da cui è stata deserializzata.
class Risorsa {
  /// Nome della risorsa.
  String _nome;

  /// Descrizione della risorsa.
  String _descrizione;

  /// Url della risorsa.
  String _url;

  /// Url dell'immagine della risorsa.
  String _immagineUrl;

  /// File corrispondente all'immagine della risorsa scaricata in locale.
  File _immagineFile;

  /// Numeri di telefono dela risorsa.
  List<String> _telefoni;

  /// Email della risorsa.
  String _email;

  /// Posizione della risorsa composta da due double rappresentanti latitudine
  /// e longitudine.
  List<double> _posizione;

  /// Mappa contenente le varie informazioni aggiuntive.
  Map<String, String> _info;

  /// Mappa corrispondente al json da cui è stata deserializzata la risorsa.
  Map<String, dynamic> _json;

  /// Url identificativo della risorsa.
  String _idUrl;

  /// Indice identificativo della risorsa.
  int _idIndice;

  /// Costruttore della Risorsa che prende una mappa json per la
  /// deserializzazione e i due identificativi(url e indice).
  Risorsa(Map<String, dynamic> parsedJson, this._idUrl, this._idIndice) {
    UtilityRisorsa ur = new UtilityRisorsa();
    this._json = ur.initJson(parsedJson);
    this._descrizione = ur.initDescrizione(parsedJson);
    this._url = ur.initUrl(parsedJson);
    this._immagineUrl = ur.initUrlImmagine(parsedJson);
    this._telefoni = ur.initTelefoni(parsedJson);
    this._email = ur.initEmail(parsedJson);
    this._posizione = ur.initPosizione(parsedJson);
    this._nome = ur.initNome(parsedJson);
    this._info = ur.initJson(parsedJson);
    _log('Creata Risorsa \'' + this._nome + '\'');
  }

  /// Metodo utile per la comparazione di due risorse tramite i due id.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Risorsa &&
          runtimeType == other.runtimeType &&
          _idUrl == other._idUrl &&
          _idIndice == other._idIndice;

  /// HashCode della risorsa generato dai due id.
  @override
  int get hashCode => _idUrl.hashCode ^ _idIndice.hashCode;

  File get immagineFile => _immagineFile;

  String get nome => _nome;

  String get descrizione => _descrizione;

  String get url => _url;

  String get immagineUrl => _immagineUrl;

  List<String> get telefoni => _telefoni;

  String get email => _email;

  List<double> get posizione => _posizione;

  Map<String, String> get info => _info;

  Map<String, dynamic> get json => _json;

  String get idUrl => _idUrl;

  int get idIndice => _idIndice;

  set immagineFile(File value) {
    _immagineFile = value;
  }

  /// Metodo privato utilizzato per la stampa dei messaggi di log.
  void _log(String messaggio) {
    log('[Risorsa] [' + DateTime.now().toString() + '] : ' + messaggio);
  }
}
