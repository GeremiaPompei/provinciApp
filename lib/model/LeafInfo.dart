
class LeafInfo {
  String argomento;
  String comune;
  String dataArchiviazione;
  String dataInizioPubblicazione;
  String dataInizioValidita;
  String descrizione;
  String oggetto;
  String servizioCompetenza;
  String terminePresentazione;
  String testoDocumeto;
  String uffiocioCompetenza;
  String url;

  LeafInfo(
      this.argomento,
      this.comune,
      this.dataArchiviazione,
      this.dataInizioPubblicazione,
      this.dataInizioValidita,
      this.descrizione,
      this.oggetto,
      this.servizioCompetenza,
      this.terminePresentazione,
      this.testoDocumeto,
      this.uffiocioCompetenza,
      this.url);

  factory LeafInfo.fromJson(Map<String, dynamic> parsedJson) {
    return LeafInfo(
        parsedJson['Argomento'],
        parsedJson['Comune'],
        parsedJson['Data di archiviazione'],
        parsedJson['Data di inizio pubblicazione'],
        parsedJson['Data di inizio validità'],
        parsedJson['Descrizione'],
        parsedJson['Oggetto'],
        parsedJson['Servizio di competenza'],
        parsedJson['Termine di presentazione'],
        parsedJson['Testo del documento'],
        parsedJson['Ufficio di competenza'],
        parsedJson['Url']);
  }

  @override
  String toString() {
    return comune +
        '\n' +
        dataArchiviazione +
        '\n' +
        dataInizioPubblicazione +
        '\n' +
        dataInizioValidita +
        '\n' +
        descrizione +
        '\n' +
        oggetto +
        '\n' +
        servizioCompetenza +
        '\n' +
        terminePresentazione +
        '\n' +
        testoDocumeto +
        '\n' +
        uffiocioCompetenza +
        '\n' +
        url;
  }
}
