class LeafInfo {
  String name;
  String description;
  String url;
  String image;
  List<String> telefono;
  String email;
  List<double> position;
  Map<String, String> info;
  Map<String, dynamic> json;

  LeafInfo(Map<String, dynamic> parsedJson) {
    this.json = parsedJson;
    this.description = checkRemove(parsedJson, 'Descrizione');
    this.url = checkRemove(parsedJson, 'Url');
    this.image = checkRemove(parsedJson, 'Immagine');
    String cells = checkRemove(parsedJson, 'Telefono');
    this.telefono = cells == null ? null : cells.split('-');
    this.email = checkRemove(parsedJson, 'E-mail');
    if (check(parsedJson['Latitudine']) && check(parsedJson['Longitudine']))
      this.position = [
        double.parse(checkRemove(parsedJson, 'Latitudine')),
        double.parse(checkRemove(parsedJson, 'Longitudine'))
      ];
    this.name = parsedJson.values.first;
    parsedJson.remove(parsedJson.keys.first);
    this.info = {};
    parsedJson.forEach((key, value) {
      if (check(value)) this.info[key] = value.toString();
    });
  }

  String checkRemove(Map<String, dynamic> parsedJson, String s) {
    String rtn;
    if (check(parsedJson[s])) {
      if (parsedJson[s].toString() != 'false') rtn = parsedJson[s].toString();
      parsedJson.remove(s);
    }
    return rtn;
  }

  bool check(dynamic s) => (s != null && s.toString() != '');

  String getName() => this.name;

  String getDescription() => this.description;

  String getImage() => this.image;

  List<String> getTelefono() => this.telefono;

  String getEmail() => this.email;

  List<double> getPosition() => this.position;

  String getUrl() => this.url;

  Map<String, String> getInfo() => this.info;

  Map<String, dynamic> getJson() => this.json;
}
