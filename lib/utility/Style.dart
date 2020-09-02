import 'package:flutter/material.dart';

const TitleTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w900,
  fontSize: 35,
  color: ThemePrimaryColor,
);
const TitleTextStyle_20 = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 20,
  color: ThemePrimaryColor,
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
  fontSize: 15,
);

const ThemePrimaryColor = Color.fromARGB(255, 72, 179, 179);
const ThemeSecondaryColor = Color.fromARGB(255, 228, 161, 58);
const BackgroundColor = Color.fromARGB(255, 237, 249, 249);

const IconSearch = 0xe8b6;
const IconCategory = 0xe1bd;
const IconComune = 0xe84f;
const IconPosition = 0xe0c8;

int findImage(String name) {
  if (name.contains('Musei') ||
      name.contains('Monumenti') ||
      name.contains('Chiese') ||
      name.contains('Rocche'))
    return 0xe84f;
  else if (name.contains('Case') ||
      name.contains('Strutture') ||
      name.contains('Teatri'))
    return 0xe88a;
  else if (name.contains('Stabilimenti'))
    return 0xeb3e;
  else if (name.contains('Eventi'))
    return 0xe878;
  else if (name.contains('Concorsi') || name.contains('Bandi'))
    return 0xe7fb;
  else if (name.contains('Shopping'))
    return 0xe8cc;
  else if (name.contains('Biblioteche'))
    return 0xe865;
  else if (name.contains('Aree')) return 0xe531;
  else return 0xe033;
}
