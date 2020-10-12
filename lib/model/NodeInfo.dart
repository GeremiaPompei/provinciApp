class NodeInfo {
  String _name;
  String _description;
  String _url;
  String _image;

  NodeInfo(this._name, this._description, this._url, this._image) {
    if (this._image != null && !this._image.startsWith('http'))
      this._image = null;
  }

  NodeInfo.fromJson(Map<String, dynamic> jsonp) {
    this._name = jsonp['display_name'];
    this._description = jsonp['description'];
    this._url = jsonp['name'];
    this._image = jsonp['image_display_url'];
  }

  String get image => _image;

  String get url => _url;

  String get description => _description;

  String get name => _name;
}
