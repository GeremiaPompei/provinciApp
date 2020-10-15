class NodeInfo {
  String _name;
  String _description;
  String _url;
  String _image;
  bool _isEmpty;

  NodeInfo(this._name, this._description, this._url, this._image,
      {bool isEmpty}) {
    this._isEmpty = isEmpty == null ? false : isEmpty;
    if (this._image != null && !this._image.startsWith('http'))
      this._image = null;
  }

  String get image => _image;

  String get url => _url;

  String get description => _description;

  String get name => _name;

  bool get isEmpty => _isEmpty;
}
