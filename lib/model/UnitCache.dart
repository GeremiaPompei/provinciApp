class UnitCache <T> {

  T element;
  DateTime date;
  String name;

  UnitCache(this.element, this.date, this.name);

  void updateDate(){
    this.date = DateTime.now();
  }

  void setName(String name) {
    this.name = name;
  }

  void setElement(T element) {
    this.element = element;
  }

  DateTime getDate() => this.date;

  T getElement() => this.element;

  String getName() => this.name;

}