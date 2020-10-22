import 'dart:io';
import 'package:provinciApp/utility/PhoneNumberParser.dart';
import 'dart:developer';

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
    this._json = _initJson(parsedJson);
    this._descrizione = _initDescrizione(parsedJson);
    this._url = _pulisciValore(parsedJson, 'Url');
    this._immagineUrl = _initUrlImmagine(parsedJson);
    this._telefoni = _initTelefoni(parsedJson);
    this._email = _pulisciValore(parsedJson, 'E-mail');
    this._posizione = _initPosizione(parsedJson);
    this._nome = _initNome(parsedJson);
    this._info = _initJson(parsedJson);
    _log('Creata Risorsa \'' + this._nome + '\'');
  }

  /// Metodo privato utile per inizializzare la mappa json pulendola dai valori
  /// nulli e convertendo i valori in stringa.
  Map<String, String> _initJson(Map<String, dynamic> parsedJson) {
    Map<String, String> res = {};
    parsedJson.forEach((key, value) {
      if (_check(value)) res[key] = value.toString();
    });
    return res;
  }

  /// Metodo privato utile a inizializzare la descrizione.
  String _initDescrizione(Map<String, dynamic> parsedJson) {
    List<String> params = ['Descrizione', 'Oggetto'];
    return _trovaParametri(parsedJson, params);
  }

  /// Metodo privato utile a inizializzare l'url dell'immagine.
  String _initUrlImmagine(Map<String, dynamic> parsedJson) {
    String res = _pulisciValore(parsedJson, 'Immagine');
    if (_check(res) && !res.startsWith('http')) res = null;
    return res;
  }

  /// Metodo privato utile ad inizializzare i numeri di telefono della risorsa
  /// riconoscendole e aggiungendoli ad una lista.
  List<String> _initTelefoni(Map<String, dynamic> parsedJson) {
    List<String> chars = [';', '-', '/', '+'];
    String cells = _pulisciValore(parsedJson, 'Telefono');
    if (cells == null) return null;
    List<String> phones = [];
    for (int i = 0; i < chars.length; i++)
      if (cells.contains(chars[i])) phones = cells.split(chars[i]);
    return phones
        .map((e) => PhoneNumberParser.parse(e))
        .where((e) => e.length >= 9)
        .toList();
  }

  /// Metodo privato utile per inizializzare la posizione della risorsa.
  List<double> _initPosizione(Map<String, dynamic> parsedJson) {
    if (_check(parsedJson['Latitudine']) && _check(parsedJson['Longitudine']))
      return [
        double.parse(_pulisciValore(parsedJson, 'Latitudine')),
        double.parse(_pulisciValore(parsedJson, 'Longitudine'))
      ];
    return null;
  }

  /// Metodo privato utile per inizializzare il nome della risorsa.
  String _initNome(Map<String, dynamic> parsedJson) {
    String res;
    List<String> params = [
      'Nome',
      'Titolo',
      'Tipologia',
      'Argomento',
      'Comune'
    ];
    res = _trovaParametri(parsedJson, params);
    if (res == null) {
      res = parsedJson.values.first;
      parsedJson.remove(this._info.keys.first);
    }
    return res;
  }

  /// Metodo privato utile per trovare i parametri all'interno di una mappa.
  String _trovaParametri(Map<String, dynamic> parsedJson, List<String> params) {
    for (String param in params) {
      String tmp = _pulisciValore(parsedJson, param);
      if (tmp != null) return tmp;
    }
    return null;
  }

  /// Metodo privato utile per pulire il valore corrispondente alla chiave nella
  /// mappa.
  String _pulisciValore(Map<String, dynamic> parsedJson, String key) {
    String rtn;
    if (_check(parsedJson[key])) {
      if (parsedJson[key].toString() != 'false')
        rtn = parsedJson[key].toString().replaceAll('\\', '');
      parsedJson.remove(key);
    }
    return rtn;
  }

  /// Metodo privato utile per controllare un valore e che ritorna vero se il
  /// controllo è andato a buon fine e falso altrimenti.
  bool _check(dynamic s) => (s != null && s.toString() != '');

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
