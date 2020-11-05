import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/view/stile/colore.dart';
import 'package:provinciApp/view/stile/icona.dart';
import 'package:provinciApp/view/stile/stiletesto.dart';

import 'custom_icon.dart';

/// CustomAppBar fornisce un'AppBar personalizzata per provinciApp che facilita
/// il suo uso.
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// Flag che indica se lo sfondo deve essere chiaro o no.
  bool _sfondoChiaro = false;

  /// Flag che indica se la schermata è primaria o viene lanciata da un'altra
  /// schermata cos da possedere il tasto indietro.
  bool _primaSchermata = false;

  /// Titolo dell'AppBar.
  String _title;

  /// Lista di widget da aggiungere all'AppBar.
  List<Widget> _actions;

  CustomAppBar(
      {bool sfondoChiaro,
      bool primaSchermata,
      String title,
      List<Widget> actions}) {
    this._sfondoChiaro = sfondoChiaro == null ? false : sfondoChiaro;
    this._primaSchermata = primaSchermata == null ? false : primaSchermata;
    this._title = title;
    this._actions = actions;
  }

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _CustomAppBarState extends State<CustomAppBar> {
  /// Stile del testo del titolo.
  TextStyle _stileScritta;

  /// Colore principale di scritte e icone.
  Color _colorePrincipale;

  /// Colore dello sfondo.
  Color _coloreSfondo;

  /// Scritta della status bar chiara o scura.
  Brightness _brightness;

  @override
  void initState() {
    if (widget._sfondoChiaro) {
      _stileScritta = StileTesto.titoloPrimario;
      _colorePrincipale = Colore.primario;
      _coloreSfondo = Colore.chiaro;
      _brightness = Brightness.light;
    } else {
      _stileScritta = StileTesto.titoloChiaro;
      _colorePrincipale = Colore.chiaro;
      _coloreSfondo = Colore.primario;
      _brightness = Brightness.dark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: _brightness,
      backgroundColor: _coloreSfondo,
      title: Text(
        widget._title,
        style: _stileScritta,
      ),
      actions: widget._actions,
      leading: widget._primaSchermata
          ? null
          : IconButton(
              icon: CustomIcon(
                Icona.indietro,
                _colorePrincipale,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
    );
  }
}
