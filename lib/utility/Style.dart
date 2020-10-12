import 'package:flutter/material.dart';

const TitleTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w900,
  fontSize: 35,
  color: ThemePrimaryColor,
);
const TitleTextStyle_20 = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 17,
  color: DarkColor,
);
const ReverseTitleTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w900,
  fontSize: 35,
  color: BackgroundColor,
);
const TitleDetaileStyle = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  fontSize: 20,
);

const ThemePrimaryColor = Color.fromARGB(255, 72, 179, 179);
const ThemeSecondaryColor = Color.fromARGB(255, 237, 249, 249);//Color(0xFFC62828);
const BackgroundColor = Color.fromARGB(255, 237, 249, 249);
const BackgroundColor2 = Color.fromARGB(255, 250, 255, 250);
const DarkColor = Colors.black;

final IconSearch = Icons.search.codePoint;
final IconCategory = Icons.widgets.codePoint;
final IconComune = Icons.account_balance.codePoint;
final IconPosition = Icons.comment.codePoint;

int findImage(String name) {
  if (name.contains('Musei') ||
      name.contains('Monumenti') ||
      name.contains('Chiese') ||
      name.contains('Rocche'))
    return Icons.account_balance.codePoint;
  else if (name.contains('Case') ||
      name.contains('Strutture') ||
      name.contains('Teatri'))
    return Icons.home.codePoint;
  else if (name.contains('Stabilimenti'))
    return Icons.beach_access.codePoint;
  else if (name.contains('Eventi'))
    return Icons.event.codePoint;
  else if (name.contains('Concorsi') || name.contains('Bandi'))
    return Icons.people.codePoint;
  else if (name.contains('Shopping'))
    return Icons.shopping_cart.codePoint;
  else if (name.contains('Biblioteche'))
    return Icons.book.codePoint;
  else if (name.contains('Aree'))
    return Icons.car_repair.codePoint;
  else
    return Icons.not_interested.codePoint;
}
