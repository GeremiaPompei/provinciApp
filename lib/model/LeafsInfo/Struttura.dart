import '../LeafInfo.dart';

class Struttura implements LeafInfo {
  String titolo;
  String tipologiaStruttura;
  var immagine;
  String comune;
  String indirizzo;
  String descrizione;
  String telefono;
  String fax;
  String mail;
  String sitoWeb;
  String periodoApertura;
  String orario;
  String latitudine;
  String longitudine;
  String accessibileDisabili;
  String url;
  Map<String, dynamic> json;

  Struttura(
      this.titolo,
      this.tipologiaStruttura,
      this.immagine,
      this.comune,
      this.indirizzo,
      this.descrizione,
      this.telefono,
      this.fax,
      this.mail,
      this.sitoWeb,
      this.periodoApertura,
      this.orario,
      this.latitudine,
      this.longitudine,
      this.accessibileDisabili,
      this.url,
      this.json);

  factory Struttura.fromJson(Map<String, dynamic> parsedJson) {
    return Struttura(
        parsedJson['Titolo'],
        parsedJson['Tipologia struttura'],
        parsedJson['Descrizione'],
        parsedJson['Immagine'],
        parsedJson['Comune'],
        parsedJson['Indirizzo'],
        parsedJson['Telefono'],
        parsedJson['Fax'],
        parsedJson['E-mail'],
        parsedJson['Sito web'],
        parsedJson['Periodo apertura'],
        parsedJson['Orario'],
        parsedJson['Latitudine'],
        parsedJson['Longitudine'],
        parsedJson['Accessibile disabili'],
        parsedJson['Url'],
        parsedJson);
  }

  @override
  String toString() {
    return this.titolo +
        '\n' +
        this.tipologiaStruttura +
        '\n' +
        this.descrizione +
        '\n' +
        this.immagine.toString() +
        '\n' +
        this.comune +
        '\n' +
        this.indirizzo +
        '\n' +
        this.telefono +
        '\n' +
        this.fax +
        '\n' +
        this.mail +
        '\n' +
        this.sitoWeb +
        '\n' +
        this.periodoApertura +
        '\n' +
        this.orario +
        '\n' +
        this.latitudine +
        '\n' +
        this.longitudine +
        '\n' +
        this.accessibileDisabili +
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
