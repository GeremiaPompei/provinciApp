import '../LeafInfo.dart';

class Suap implements LeafInfo {
  String titolo;
  String titolare;
  String referente;
  String contatto;
  String descrizione;
  String categorie;
  String tag;
  String documentazioneTecnica;
  String descrizioneCampi;
  String coperturaGeografica;
  String coperturaTemporaleDataInizio;
  String coperturaTemporaleDataFine;
  String dataPubblicazione;
  String formato;
  String codificaCaratteri;
  String dimensione;
  Map<String, dynamic> json;

  Suap(
      this.titolo,
      this.titolare,
      this.referente,
      this.contatto,
      this.descrizione,
      this.categorie,
      this.tag,
      this.documentazioneTecnica,
      this.descrizioneCampi,
      this.coperturaGeografica,
      this.coperturaTemporaleDataInizio,
      this.coperturaTemporaleDataFine,
      this.dataPubblicazione,
      this.formato,
      this.codificaCaratteri,
      this.dimensione,
      this.json);

  factory Suap.fromJson(Map<String, dynamic> parsedJson) {
    return Suap(
        parsedJson['MetaData']['Titolo'],
        parsedJson['MetaData']['Titolare'],
        parsedJson['MetaData']['Referente'],
        parsedJson['MetaData']['Contatto'],
        parsedJson['MetaData']['Descrizione'],
        parsedJson['MetaData']['Categorie'],
        parsedJson['MetaData']['Tag'],
        parsedJson['MetaData']['DocumentazioneTecnica'],
        parsedJson['MetaData']['CoperturaGeografica'],
        parsedJson['MetaData']['CoperturaTemporaleDataInizio'],
        parsedJson['MetaData']['CoperturaTemporaleDataFine'],
        parsedJson['MetaData']['DataPubblicazione'],
        parsedJson['MetaData']['Formato'],
        parsedJson['MetaData']['CodificaCaratteri'],
        parsedJson['MetaData']['Accessibile disabili'],
        parsedJson['MetaData']['Dimensione'],
        parsedJson);
  }

  @override
  String toString() {
    return this.titolo +
        '\n' +
        this.titolare +
        '\n' +
        this.descrizione +
        '\n' +
        this.referente.toString() +
        '\n' +
        this.contatto +
        '\n' +
        this.categorie +
        '\n' +
        this.tag +
        '\n' +
        this.documentazioneTecnica +
        '\n' +
        this.descrizioneCampi +
        '\n' +
        this.coperturaGeografica +
        '\n' +
        this.coperturaTemporaleDataInizio +
        '\n' +
        this.coperturaTemporaleDataFine +
        '\n' +
        this.dataPubblicazione +
        '\n' +
        this.formato +
        '\n' +
        this.dimensione;
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
    return null;
  }

  @override
  Map<String, dynamic> getJson() {
    return this.json;
  }
}
