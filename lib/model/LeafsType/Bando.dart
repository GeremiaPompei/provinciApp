import '../LeafInfo.dart';

class Bando implements LeafInfo {
  String comune;
  String contratto;
  String dataArchiviazione;
  String CPV;
  String CUP;
  String importoBaseAsta;
  String oggetto;
  String indirizzo;
  String provincia;
  String pubblicazione;
  String requisitiQualificazione;
  String riferimento;
  String rilevanzaComunitaria;
  String SCP;
  String settoreApplicazione;
  String tipologia;
  String ufficioCompetenza;
  String urlSCP;
  String url;


  Bando(
      this.comune,
      this.contratto,
      this.dataArchiviazione,
      this.CPV,
      this.CUP,
      this.importoBaseAsta,
      this.oggetto,
      this.indirizzo,
      this.provincia,
      this.pubblicazione,
      this.requisitiQualificazione,
      this.riferimento,
      this.rilevanzaComunitaria,
      this.SCP,
      this.settoreApplicazione,
      this.tipologia,
      this.ufficioCompetenza,
      this.urlSCP,
      this.url);

  factory Bando.fromJson(Map<String, dynamic> parsedJson) {
    return Bando(
        parsedJson['Comune'],
        parsedJson['Contratto'],
        parsedJson['CPV'],
        parsedJson['CUP'],
        parsedJson['Data di archiviazione'],
        parsedJson['Importo a base asta'],
        parsedJson['Indirizzo'],
        parsedJson['Oggetto'],
        parsedJson['Provincia'],
        parsedJson['Pubblicazione'],
        parsedJson['Requisiti di qualificazione'],
        parsedJson['Riferimento'],
        parsedJson['Rilevanza comunitaria'],
        parsedJson['SCP'],
        parsedJson['Settore di applicazione'],
        parsedJson['Tipologia'],
        parsedJson['Ufficio di competenza'],
        parsedJson['Url'],
        parsedJson['Url SCP']);
  }

  @override
  String toString() {
    return this.comune + '\n' +
    this.contratto + '\n' +
    this.dataArchiviazione + '\n' +
    this.CPV + '\n' +
    this.CUP + '\n' +
    this.importoBaseAsta + '\n' +
    this.oggetto + '\n' +
    this.indirizzo + '\n' +
    this.provincia + '\n' +
    this.pubblicazione + '\n' +
    this.requisitiQualificazione + '\n' +
    this.riferimento + '\n' +
    this.rilevanzaComunitaria + '\n' +
    this.SCP + '\n' +
    this.settoreApplicazione + '\n' +
    this.tipologia + '\n' +
    this.ufficioCompetenza + '\n' +
    this.urlSCP + '\n' +
    this.url;
  }

  @override
  String getName() {
    return this.comune;
  }

  @override
  String getDescription() {
    return this.oggetto;
  }

  @override
  String getUrl() {
    return this.url;
  }
}