class UnitCache <T> {

  DateTime date;
  T element;

  UnitCache() {
    this.date = DateTime.now();
    this.element = null;
  }

  void setDate(DateTime date) {
    this.date = date;
  }

  void setElement(T element) {
    this.element = element;
  }

  DateTime getDate() {
    return this.date;
  }

  T getElement() {
    return this.element;
  }

}