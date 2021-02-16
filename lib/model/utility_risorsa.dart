import 'package:provinciApp/model/costanti/costanti_risorsa.dart';

/// Un UtilityRisorsa fornisce ad una risorsa i metodi per controllare e
/// ripulire i propri parametri.
class UtilityRisorsa {
  /// Metodo utile per inizializzare la mappa json pulendola dai valori
  /// nulli e convertendo i valori in stringa.
  Map<String, String> initJson(Map<String, dynamic> parsedJson) {
    Map<String, String> res = {};
    parsedJson.forEach((key, value) {
      if (_check(value)) res[key] = value.toString();
    });
    return res;
  }

  /// Metodo utile a inizializzare la descrizione della risorsa.
  String initDescrizione(Map<String, dynamic> parsedJson) =>
      _trovaParametri(parsedJson, CostantiRisorsa.descrizione);

  /// Metodo utile a inizializzare l'url della risorsa.
  String initUrl(Map<String, dynamic> parsedJson) =>
      _pulisciValore(parsedJson, CostantiRisorsa.url);

  /// Metodo utile a inizializzare l'url dell'immagine della risorsa.
  String initUrlImmagine(Map<String, dynamic> parsedJson) {
    String res = _pulisciValore(parsedJson, CostantiRisorsa.urlImmagine);
    if (_check(res) && !res.startsWith('http')) res = null;
    return res;
  }

  /// Metodo utile ad inizializzare i numeri di telefono della risorsa
  /// riconoscendole e aggiungendoli ad una lista.
  List<String> initTelefoni(Map<String, dynamic> parsedJson) {
    String cells = _pulisciValore(parsedJson, CostantiRisorsa.telefoni);
    if (cells == null) return null;
    List<String> phones = [cells];
    for (int i = 0; i < CostantiRisorsa.telefoniDivisori.length; i++)
      if (cells.contains(CostantiRisorsa.telefoniDivisori[i]))
        phones = cells.split(CostantiRisorsa.telefoniDivisori[i]);
    return phones
        .map((e) => _parseNumero(e))
        .where((e) => e.length >= 9)
        .toList();
  }

  /// Metodo privato utile ad inizializzare l'email della risorsa.
  String initEmail(Map<String, dynamic> parsedJson) =>
      _pulisciValore(parsedJson, CostantiRisorsa.email);

  /// Metodo privato utile per ripulire il numero di telefono da eventuali
  /// caratteri non adatti.
  String _parseNumero(String text) {
    String number = '';
    for (int i = 0; i < text.length; i++) {
      if (text[i] == '+' || text[i] == ' ' || _isInt(text[i])) {
        number += text[i];
      }
    }
    return number;
  }

  /// Metodo privato utile per determinare se una stringa puo essere convertita
  /// in intero o no.
  bool _isInt(String num) {
    try {
      int.parse(num);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Metodo utile per inizializzare la posizione della risorsa.
  List<double> initPosizione(Map<String, dynamic> parsedJson) {
    if (_check(parsedJson['Latitudine']) && _check(parsedJson['Longitudine']))
      return [
        double.parse(_pulisciValore(parsedJson, CostantiRisorsa.posizione[0])),
        double.parse(_pulisciValore(parsedJson, CostantiRisorsa.posizione[1]))
      ];
    return null;
  }

  /// Metodo utile per inizializzare il nome della risorsa.
  String initNome(Map<String, dynamic> parsedJson) {
    String res;
    res = _trovaParametri(parsedJson, CostantiRisorsa.nome);
    if (res == null) {
      res = parsedJson.values.first;
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

  /// Metodo utile per pulire il valore corrispondente alla chiave nella
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
}
