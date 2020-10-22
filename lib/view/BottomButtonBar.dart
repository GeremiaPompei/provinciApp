import 'package:provinciApp/utility/Style.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      color: PrimaryColor,
      backgroundColor: BackgroundColor,
      buttonBackgroundColor: PrimaryColor,
      items: <Widget>[
        Icon(
          IconData(IconComune, fontFamily: 'MaterialIcons'),
          color: BackgroundColor,
        ),
        Icon(
          IconData(IconSearch, fontFamily: 'MaterialIcons'),
          color: BackgroundColor,
        ),
        Icon(
          IconData(IconCategory, fontFamily: 'MaterialIcons'),
          color: BackgroundColor,
        ),
      ],
      animationDuration: Duration(milliseconds: 300),
      animationCurve: Curves.easeInOutCirc,
      onTap: _func,
    );
  }
}
