import 'package:flutter/material.dart';
import 'colore.dart';

/// StileTesto è la classe contenente gli stili di testo utilizzati in
/// provinciApp.
class StileTesto {
  /// Stile di testo utilizzato per il titolo con colore primario.
  static TextStyle titoloPrimario = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w900,
    fontSize: 25,
    color: Colore.primario,
  );

  /// Stile di testo utilizzato per il titolo con colore chiaro.
  static TextStyle titoloChiaro = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w900,
    fontSize: 25,
    color: Colore.chiaro,
  );

  /// Stile di testo utilizzato per il sottotitolo.
  static TextStyle sottotitolo = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 17,
    color: Colore.scuro,
  );

  /// Stile di testo utilizzato per corpo.
  static TextStyle corpo = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: Colore.primario,
  );
}
