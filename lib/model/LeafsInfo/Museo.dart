import '../LeafInfo.dart';

class Museo implements LeafInfo {
  String comune;
  String nome;
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
  String situazione;
  String costruzione;
  String opereInMostra;
  String accesso;
  Map<String, dynamic> json;

  Museo(
      this.comune,
      this.nome,
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
      this.situazione,
      this.costruzione,
      this.opereInMostra,
      this.accesso,
      this.json);

  factory Museo.fromJson(Map<String, dynamic> parsedJson) {
    return Museo(
        parsedJson['Comune'],
        parsedJson['Nome'],
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
        parsedJson['Situazione'],
        parsedJson['Costruzione'],
        parsedJson['Opere in mostra'],
        parsedJson['Accesso'],
        parsedJson);
  }

  @override
  String toString() {
    return this.comune +
        '\n' +
        this.nome +
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
        this.sitoEsterno +
        '\n' +
        this.mail +
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
        this.situazione +
        '\n' +
        this.costruzione +
        '\n' +
        this.opereInMostra +
        '\n' +
        this.accesso;
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
