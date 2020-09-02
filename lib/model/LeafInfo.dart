import 'dart:io';

class LeafInfo {
  String _name;
  String _description;
  String _url;
  String _image;
  File _imageFile;
  List<String> _telefono;
  String _email;
  List<double> _position;
  Map<String, String> _info;
  Map<String, dynamic> _json;
  String _sourceUrl;
  int _sourceIndex;

  LeafInfo(
      Map<String, dynamic> parsedJson, this._sourceUrl, this._sourceIndex) {
    this._json = {};
    parsedJson.forEach((key, value) {
      if (check(value)) this._json[key] = value.toString();
    });
    this._description = checkRemove(parsedJson, 'Descrizione');
    this._url = checkRemove(parsedJson, 'Url');
    this._image = checkRemove(parsedJson, 'Immagine');
    if (check(this._image) && !this._image.startsWith('http'))
      this._image = null;
    String cells = checkRemove(parsedJson, 'Telefono');
    if(cells != null){
      if(cells.contains(';'))
        this._telefono = cells.split(';');
      else if(cells.contains('-'))
        this._telefono = cells.split('-');
      else
        this._telefono = [cells];
    }
    this._email = checkRemove(parsedJson, 'E-mail');
    if (check(parsedJson['Latitudine']) && check(parsedJson['Longitudine']))
      this._position = [
        double.parse(checkRemove(parsedJson, 'Latitudine')),
        double.parse(checkRemove(parsedJson, 'Longitudine'))
      ];
    this._name = checkRemove(parsedJson, 'Nome');
    this._name == null ? this._name = checkRemove(parsedJson, 'Titolo') : null;
    this._name == null
        ? this._name = checkRemove(parsedJson, 'Tipologia')
        : null;
    this._name == null
        ? this._name = checkRemove(parsedJson, 'Argomento')
        : null;
    this._name == null ? this._name = checkRemove(parsedJson, 'Comune') : null;
    this._info = {};
    parsedJson.forEach((key, value) {
      if (check(value)) this._info[key] = value.toString();
    });
    if (this._name == null) {
      this._name = this._info.values.first;
      this._info.remove(this._info.keys.first);
    }
  }

  String checkRemove(Map<String, dynamic> parsedJson, String s) {
    String rtn;
    if (check(parsedJson[s])) {
      if (parsedJson[s].toString() != 'false')
        rtn = parsedJson[s].toString().replaceAll('\\', '');
      parsedJson.remove(s);
    } else
      rtn = null;
    return rtn;
  }

  bool check(dynamic s) => (s != null && s.toString() != '');

  set imageFile(File value) {
    _imageFile = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeafInfo &&
          runtimeType == other.runtimeType &&
          _sourceUrl == other._sourceUrl &&
          _sourceIndex == other._sourceIndex;

  @override
  int get hashCode => _sourceUrl.hashCode ^ _sourceIndex.hashCode;

  File get imageFile => _imageFile;

  String get name => _name;

  String get description => _description;

  String get url => _url;

  String get image => _image;

  List<String> get telefono => _telefono;

  String get email => _email;

  List<double> get position => _position;

  Map<String, String> get info => _info;

  Map<String, dynamic> get json => _json;

  String get sourceUrl => _sourceUrl;

  int get sourceIndex => _sourceIndex;
}
