class PhoneNumberParser {
  static String parse(String text) {
    String number = '';
    for (int i = 0; i < text.length; i++) {
      if (text[i] == '+' || text[i] == ' ' || _isInt(text[i])) {
        number += text[i];
      }
    }
    return number;
  }

  static bool _isInt(String num) {
    try {
      int.parse(num);
      return true;
    } catch (e) {
      return false;
    }
  }
}
