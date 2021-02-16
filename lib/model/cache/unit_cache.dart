import 'dart:developer';

/// Unità della cache utile per manipolare i vari elementi in unità all'interno
/// della cache. Questa unità ha come attributi un nome identificativo, un'icona,
/// una data per capire quando è stato memorizzato un elemento nel tempo e
/// aggiornarlo in base alle strategie di memorizzazione e l'elemento che è di
/// un tipo generico T così da rendere tale unità slegata da ogni tipo di
/// elemento memorizzato rendendola modulare.
class UnitCache<T> {
  /// Elemento dell'unità di cache.
  T _elemento;

  /// Data dell'unità di cache.
  DateTime _data;

  /// Nome dell'unità di cache.
  String _nome;

  /// Icona dell'unità di cache.
  int _icona;

  /// Costruttore della UnitCache che inizializza tutte le variabili con
  /// quelle passategli.
  UnitCache(this._elemento, this._data, this._nome, this._icona) {
    _log('Costruita UnitCache \'' + this.nome + '\'');
  }

  /// Metodo utile per l'aggiornamento della data dell'unità di cache.
  void updateDate() => this._data = DateTime.now();

  set icona(int value) {
    _icona = value;
  }

  set nome(String value) {
    _nome = value;
  }

  set elemento(T value) {
    _elemento = value;
  }

  String get nome => _nome;

  DateTime get data => _data;

  T get elemento => _elemento;

  int get icona => _icona;

  /// Metodo privato utilizzato per la stampa dei messaggi di log.
  void _log(String messaggio) {
    log('[UnitCache] [' + DateTime.now().toString() + '] : ' + messaggio);
  }
}
