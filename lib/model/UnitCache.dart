class UnitCache <T> {

  T _element;
  DateTime _date;
  String _name;
  int _icon;

  UnitCache(this._element, this._date, this._name,this._icon);

  void updateDate() => this._date = DateTime.now();

  set icon(int value) {
    _icon = value;
  }

  set name(String value) {
    _name = value;
  }

  set element(T value) {
    _element = value;
  }

  String get name => _name;

  DateTime get date => _date;

  T get element => _element;

  int get icon => _icon;
}