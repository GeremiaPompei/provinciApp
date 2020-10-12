class NodeInfo {
  String _name;
  String _description;
  String _url;
  String _image;

  NodeInfo(this._name, this._description, this._url, this._image) {
    if (this._image != null && !this._image.startsWith('http'))
      this._image = null;
  }

  String get image => _image;

  String get url => _url;

  String get description => _description;

  String get name => _name;
}
