/// Classe contenente le costanti utili per la serializzazione e
/// deserializzazione di una risorsa.
class CostantiRisorsa {
  /// Lista di stringhe utile per ricavare il nome della risorsa.
  static const nome = ['Nome', 'Titolo', 'Tipologia', 'Argomento', 'Comune'];

  /// Lista di stringhe utile per ricavare la descrizione della risorsa.
  static const descrizione = ['Descrizione', 'Oggetto'];

  /// Stringa utile per ricavare l'url dell'immagine della risorsa.
  static const urlImmagine = 'Immagine';

  /// Stringa utile per ricavare il path dell'immagine della risorsa.
  static const pathImmagine = 'Path Immagine';

  /// Stringa utile per ricavare il numero di telefono della risorsa.
  static const telefoni = 'Telefono';

  /// Lista di stringhe utile per ricavare i divisori tra i numeri di telefono
  /// della risorsa.
  static const telefoniDivisori = [';', '-', '/', '+'];

  /// Lista di stringhe utile per ricavare la posizione della risorsa.
  static const posizione = ['Latitudine', 'Longitudine'];

  /// Stringa utile per ricavare l'url della risorsa.
  static const url = 'Url';

  /// Stringa utile per ricavare l'email della risorsa.
  static const email = 'E-mail';
}
