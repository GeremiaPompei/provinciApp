import 'package:flutter/cupertino.dart';

/// CustomIcon fornisce l'icona personalizzata di provinciApp dati il codice e
/// il colore dell'icona.
class CustomIcon extends StatefulWidget {
  /// Codice dell'icona
  int _codice;

  /// Colore dell'icona.
  Color _colore;

  CustomIcon(this._codice, this._colore);

  @override
  _CustomIconState createState() => _CustomIconState();
}

class _CustomIconState extends State<CustomIcon> {
  @override
  Widget build(BuildContext context) {
    return Icon(
      IconData(widget._codice, fontFamily: 'MaterialIcons'),
      color: widget._colore,
    );
  }
}
