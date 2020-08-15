import '../LeafInfo.dart';

class Evento implements LeafInfo {
  String comune;
  String titolo;
  String descrizione;
  var immagine;
  String locandinaEvento;
  String costi;
  String tipologiaEvento;
  String organizzatore;
  String url;
  String latitudine;
  String longitudine;
  String inizio;
  String termine;
  Map<String, dynamic> json;

  Evento(
      this.comune,
      this.titolo,
      this.descrizione,
      this.immagine,
      this.locandinaEvento,
      this.costi,
      this.tipologiaEvento,
      this.organizzatore,
      this.url,
      this.latitudine,
      this.longitudine,
      this.inizio,
      this.termine,
      this.json);

  factory Evento.fromJson(Map<String, dynamic> parsedJson) {
    return Evento(
        parsedJson['Comune'],
        parsedJson['Titolo'],
        parsedJson['Descrizione'],
        parsedJson['Immagine'],
        parsedJson['Locandina evento'],
        parsedJson['Costi'],
        parsedJson['Tipologia evento'],
        parsedJson['Organizzatore'],
        parsedJson['Url'],
        parsedJson['Latitudine'],
        parsedJson['Longitudine'],
        parsedJson['Inizio'],
        parsedJson['Termine'],
        parsedJson);
  }

  @override
  String toString() {
    return this.comune +
        '\n' +
        this.titolo +
        '\n' +
        this.descrizione +
        '\n' +
        this.immagine.toString() +
        '\n' +
        this.locandinaEvento +
        '\n' +
        this.costi +
        '\n' +
        this.tipologiaEvento +
        '\n' +
        this.organizzatore +
        '\n' +
        this.termine +
        '\n' +
        this.inizio +
        '\n' +
        this.latitudine +
        '\n' +
        this.longitudine +
        '\n' +
        this.url;
  }

  @override
  String getName() {
    return this.titolo;
  }

  @override
  String getDescription() {
    return this.descrizione;
  }

  @override
  String getUrl() {
    return this.url;
  }

  @override
  Map<String, dynamic> getJson() {
    return this.json;
  }
}
