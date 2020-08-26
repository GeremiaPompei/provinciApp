class UnitCache <T> {

  T _element;
  DateTime _date;
  String _name;

  UnitCache(this._element, this._date, this._name);

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