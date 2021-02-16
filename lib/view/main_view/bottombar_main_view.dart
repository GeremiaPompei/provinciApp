import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/view/stile/colore.dart';
import 'package:provinciApp/view/stile/icona.dart';
import 'package:provinciApp/view/costanti/custom_icon.dart';

/// BottomBarMainView è la barra al di sotto della vista principale con la quale
/// selezionare le sottoviste.
class BottomBarMainView extends StatefulWidget {
  /// Funzione per selezionare sottoVista.
  void Function(int) _selezionaSottoView;

  /// Indice corrispondente alla sottoVista.
  int _index;

  BottomBarMainView(this._selezionaSottoView, this._index);

  @override
  _BottomBarMainViewState createState() => _BottomBarMainViewState();
}

class _BottomBarMainViewState extends State<BottomBarMainView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8.0,
      child: Container(
        color: Colore.chiaro,
        padding: EdgeInsets.only(top: 10),
        child: CurvedNavigationBar(
          index: widget._index,
          color: Colore.primario,
          backgroundColor: Colore.chiaro,
          buttonBackgroundColor: Colore.primario,
          items: <Widget>[
            CustomIcon(Icona.comuni, Colore.chiaro),
            CustomIcon(Icona.cerca, Colore.chiaro),
            CustomIcon(Icona.categorie, Colore.chiaro),
          ],
          animationDuration: Duration(milliseconds: 300),
          animationCurve: Curves.easeInOutCirc,
          onTap: widget._selezionaSottoView,
        ),
      ),
    );
  }
}
