import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/utility/stile/colore.dart';
import 'package:provinciApp/utility/stile/icona.dart';

class BottomButtonDown extends StatefulWidget {
  void Function(int) _func;
  int _index;

  BottomButtonDown(this._func, this._index);

  @override
  _BottomButtonDownState createState() =>
      _BottomButtonDownState(this._func, this._index);
}

class _BottomButtonDownState extends State<BottomButtonDown> {
  void Function(int) _func;
  int _index;

  _BottomButtonDownState(this._func, this._index);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: this._index,
      color: Colore.primario,
      backgroundColor: Colore.chiaro,
      buttonBackgroundColor: Colore.primario,
      items: <Widget>[
        Icon(
          IconData(Icona.comuni, fontFamily: 'MaterialIcons'),
          color: Colore.chiaro,
        ),
        Icon(
          IconData(Icona.cerca, fontFamily: 'MaterialIcons'),
          color: Colore.chiaro,
        ),
        Icon(
          IconData(Icona.categorie, fontFamily: 'MaterialIcons'),
          color: Colore.chiaro,
        ),
      ],
      animationDuration: Duration(milliseconds: 300),
      animationCurve: Curves.easeInOutCirc,
      onTap: _func,
    );
  }
}
