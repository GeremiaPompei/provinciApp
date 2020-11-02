import 'dart:developer';

/// Un Pacchetto è un elemento del sistema che permette di creare oggetti che
/// hanno come attributi un nome, una descrizione, un url, un'immagine e un flag
/// che determina se il pacchetto contiene o no altri elementi. Gli elementi che
/// contiene un pacchetto sono identificati dall'url e possono essere risorse o
/// altri pacchetti. Sia le categorie che le organizzazioni sono pacchetti che
/// contengono altri pacchetti. Anche gli extra sono particolari pacchetti che
/// contengono l'url a cui si verrà indirizzati nel browser.
class Pacchetto {
  /// Nome del pacchetto.
  String _nome;

  /// Descrizione del pacchetto.
  String _descrizione;

  /// Url del pacchetto.
  String _url;

  /// Url dell'immagine del pacchetto.
  String _immagineUrl;

  /// Flag che indica true se il pacchetto contiene qualche elemento, false
  /// altrimenti.
  bool _isEmpty;

  /// Costruttore del Pacchetto che inizializza le variabili con gli elementi
  /// passati controllandoli.
  Pacchetto(this._nome, this._descrizione, this._url,
      {String immagineUrl, bool isEmpty}) {
    this._isEmpty = isEmpty == null ? false : isEmpty;
    if (immagineUrl != null && immagineUrl.startsWith('http'))
      this._immagineUrl = immagineUrl;
    _log('Creato Pacchetto \''+this._nome+'\'');
  }

  String get immagineUrl => _immagineUrl;

  String get url => _url;

  String get descrizione => _descrizione;

  String get nome => _nome;

  bool get isEmpty => _isEmpty;

  /// Metodo privato utilizzato per la stampa dei messaggi di log.
  void _log(String messaggio) {
    log('[Pacchetto] [' + DateTime.now().toString() + '] : ' + messaggio);
  }
}
