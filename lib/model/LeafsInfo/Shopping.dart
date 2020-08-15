import '../LeafInfo.dart';

class Shopping implements LeafInfo {
  String comune;
  String nome;
  String descrizione;
  String indirizzo;
  String telefono;
  String fax;
  String orario;
  String sitoWeb;
  String mail;
  String latitudine;
  String longitudine;
  String url;
  Map<String, dynamic> json;

  Shopping(
      this.comune,
      this.nome,
      this.descrizione,
      this.indirizzo,
      this.telefono,
      this.fax,
      this.orario,
      this.sitoWeb,
      this.mail,
      this.latitudine,
      this.longitudine,
      this.url,
      this.json);

  factory Shopping.fromJson(Map<String, dynamic> parsedJson) {
    return Shopping(
        parsedJson['Comune'],
        parsedJson['Nome'],
        parsedJson['Descrizione'],
        parsedJson['Indirizzo'],
        parsedJson['Telefono'],
        parsedJson['Fax'],
        parsedJson['Orario'],
        parsedJson['Sito web'],
        parsedJson['E-mail'],
        parsedJson['Latitudine'],
        parsedJson['Longitudine'],
        parsedJson['Url'],
        parsedJson);
  }

  @override
  String toString() {
    return this.nome +
        '\n' +
        this.descrizione +
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
        this.orario +
        '\n' +
        this.latitudine +
        '\n' +
        this.longitudine +
        '\n' +
        this.url;
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
