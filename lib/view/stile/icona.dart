import 'package:flutter/material.dart';

/// Icona è la classe contenente le icone utilizzate all'interno di provinciApp.
class Icona {
  /// Icona rappresentante la ricerca.
  static final cerca = Icons.search.codePoint;

  /// Icona rappresentante le categorie.
  static final categorie = Icons.widgets.codePoint;

  /// Icona rappresentante i comuni.
  static final comuni = Icons.account_balance.codePoint;

  /// Icona rappresentante la posizione.
  static final posizione = Icons.location_on.codePoint;

  /// Icona rappresentante gli extra.
  static final extra = Icons.extension_rounded.codePoint;

  /// Icona rappresentante la parte online di provinciApp.
  static final online = Icons.file_upload.codePoint;

  /// Icona rappresentante la parte offline di provinciApp.
  static final offline = Icons.file_download.codePoint;

  /// Icona rappresentante la freccia indietro.
  static final indietro = Icons.arrow_back_ios.codePoint;

  /// Icona rappresentante il salvataggio offline.
  static final salvaOffline = Icons.add_circle_outline.codePoint;

  /// Icona rappresentante la rimozione dagli elementi offline.
  static final rimuoviOffline = Icons.remove_circle_outline.codePoint;

  /// Icona rappresentante la condivisione.
  static final condividi = Icons.share.codePoint;

  /// Icona rappresentante l'email.
  static final email = Icons.mail.codePoint;

  /// Icona rappresentante il collegamento ad un url.
  static final link = Icons.link.codePoint;

  /// Icona rappresentante il telefono.
  static final telefono = Icons.phone.codePoint;

  /// Metodo utile per ritrovare il codice dell'intero corrispondente all'icona
  /// data una parola.
  static int trovaIcona(String name) {
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
}
