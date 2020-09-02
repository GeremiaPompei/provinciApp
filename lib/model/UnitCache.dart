class UnitCache <T> {

  T _element;
  DateTime _date;
  String _name;
  int _image;

  UnitCache(this._element, this._date, this._name,this._image);

  int get image => _image;

  set image(int value) {
    _image = value;
  }

  void updateDate() => this._date = DateTime.now();

  set name(String value) {
    _name = value;
  }

  set element(T value) {
    _element = value;
  }

  String get name => _name;

  DateTime get date => _date;

  T get element => _element;
}