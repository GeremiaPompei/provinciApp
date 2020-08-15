import '../LeafInfo.dart';

class Monumento implements LeafInfo {
  String comune;
  String nome;
  String tipologiaMonumento;
  String descrizione;
  String localita;
  String indirizzo;
  String telefono;
  String fax;
  String orario;
  String sitoEsterno;
  String mail;
  String latitudine;
  String longitudine;
  String visitablie;
  String accessibileDisabili;
  String url;
  String costruzione;
  Map<String, dynamic> json;

  Monumento(
      this.comune,
      this.nome,
      this.tipologiaMonumento,
      this.descrizione,
      this.localita,
      this.indirizzo,
      this.telefono,
      this.fax,
      this.orario,
      this.sitoEsterno,
      this.mail,
      this.latitudine,
      this.longitudine,
      this.visitablie,
      this.accessibileDisabili,
      this.url,
      this.costruzione,
      this.json);

  factory Monumento.fromJson(Map<String, dynamic> parsedJson) {
    return Monumento(
        parsedJson['Comune'],
        parsedJson['Nome'],
        parsedJson['Tipologia monumento'],
        parsedJson['Descrizione'],
        parsedJson['Località'],
        parsedJson['Indirizzo'],
        parsedJson['Telefono'],
        parsedJson['Fax'],
        parsedJson['Orario'],
        parsedJson['Sito esterno'],
        parsedJson['E-mail'],
        parsedJson['Latitudine'],
        parsedJson['Longitudine'],
        parsedJson['Visitabile'],
        parsedJson['Accessibile disabili'],
        parsedJson['Url'],
        parsedJson['Costruzione'],
        parsedJson);
  }

  @override
  String toString() {
    return this.comune +
        '\n' +
        this.nome +
        '\n' +
        this.tipologiaMonumento +
        '\n' +
        this.descrizione +
        '\n' +
        this.localita +
        '\n' +
        this.indirizzo +
        '\n' +
        this.telefono +
        '\n' +
        this.fax +
        '\n' +
        this.orario +
        '\n' +
        this.mail +
        '\n' +
        this.sitoEsterno +
        '\n' +
        this.latitudine +
        '\n' +
        this.longitudine +
        '\n' +
        this.visitablie +
        '\n' +
        this.accessibileDisabili +
        '\n' +
        this.url +
        '\n' +
        this.costruzione;
  }

  @override
  String getName() {
    return this.nome;
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
