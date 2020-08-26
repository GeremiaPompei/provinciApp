class NodeInfo{
  String _name;
  String _description;
  String _url;
  String _image;

  NodeInfo(this._name, this._description, this._url);

  @override
  String toString(){
    if(_description == null)
      return _name;
    return _name + ': ' + _description;
  }

  String get image => _image;

  String get url => _url;

  String get description => _description;

  String get name => _name;
}