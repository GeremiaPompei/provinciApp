import 'dart:io';

import 'package:MC/utility/PhoneNumberParser.dart';

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
    this._json = _initMap(parsedJson);
    this._description = _initDescription(parsedJson);
    this._url = _checkRemove(parsedJson, 'Url');
    this._image = _initImage(parsedJson);
    this._telefono = _initPhone(parsedJson);
    this._email = _checkRemove(parsedJson, 'E-mail');
    this._position = _initPosition(parsedJson);
    this._name = _initName(parsedJson);
    this._info = _initMap(parsedJson);
  }

  String _initImage(Map<String, dynamic> parsedJson) {
    String res = _checkRemove(parsedJson, 'Immagine');
    if (_check(res) && !res.startsWith('http')) res = null;
    return res;
  }

  List<String> _initPhone(Map<String, dynamic> parsedJson) {
    List<String> chars = [';', '-', '/', '+'];
    String cells = _checkRemove(parsedJson, 'Telefono');
    if (cells == null) return null;
    List<String> phones = [];
    for (int i = 0; i < chars.length; i++) {
      if (cells.contains(chars[i])) phones = cells.split(chars[i]);
    }
    return phones
        .map((e) => PhoneNumberParser.parse(e))
        .toList()
        .where((e) => e.length >= 9)
        .toList();
  }

  List<double> _initPosition(Map<String, dynamic> parsedJson) {
    if (_check(parsedJson['Latitudine']) && _check(parsedJson['Longitudine']))
      return [
        double.parse(_checkRemove(parsedJson, 'Latitudine')),
        double.parse(_checkRemove(parsedJson, 'Longitudine'))
      ];
    return null;
  }

  Map<String, String> _initMap(Map<String, dynamic> parsedJson) {
    Map<String, String> res = {};
    parsedJson.forEach((key, value) {
      if (_check(value)) res[key] = value.toString();
    });
    return res;
  }

  String _initDescription(Map<String, dynamic> parsedJson) {
    List<String> params = ['Descrizione', 'Oggetto'];
    return _findParam(parsedJson, params);
  }

  String _initName(Map<String, dynamic> parsedJson) {
    String res;
    List<String> params = [
      'Nome',
      'Titolo',
      'Tipologia',
      'Argomento',
      'Comune'
    ];
    res = _findParam(parsedJson, params);
    if (res == null) {
      res = parsedJson.values.first;
      parsedJson.remove(this._info.keys.first);
    }
    return res;
  }

  String _findParam(Map<String, dynamic> parsedJson, List<String> params) {
    for (String param in params) {
      String tmp = _checkRemove(parsedJson, param);
      if (tmp != null) {
        return tmp;
      }
    }
    return null;
  }

  String _checkRemove(Map<String, dynamic> parsedJson, String s) {
    String rtn;
    if (_check(parsedJson[s])) {
      if (parsedJson[s].toString() != 'false')
        rtn = parsedJson[s].toString().replaceAll('\\', '');
      parsedJson.remove(s);
    }
    return rtn;
  }

  bool _check(dynamic s) => (s != null && s.toString() != '');

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeafInfo &&
          runtimeType == other.runtimeType &&
          _sourceUrl == other._sourceUrl &&
          _sourceIndex == other._sourceIndex;

  set imageFile(File value) {
    _imageFile = value;
  }

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
