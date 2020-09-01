import 'package:MC/utility/Style.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomButtonDown extends StatefulWidget {
  void Function(int) _func;
  int _index;

  BottomButtonDown(this._func,this._index);

  @override
  _BottomButtonDownState createState() =>
      _BottomButtonDownState(this._func,this._index);
}

class _BottomButtonDownState extends State<BottomButtonDown> {
  void Function(int) _func;
  int _index;

  _BottomButtonDownState(this._func,this._index);

  void onItemTapped(index) {
    setState(() {
      _func(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: this._index,
      color: ThemePrimaryColor,
      backgroundColor: Colors.white,
      buttonBackgroundColor: ThemeSecondaryColor,
      items: <Widget>[
        Icon(Icons.home),
        Icon(Icons.event),
        Icon(Icons.free_breakfast),
        Icon(Icons.file_download)
      ],
      animationDuration: Duration(milliseconds: 300),
      animationCurve: Curves.easeInOutCirc,
      onTap: onItemTapped,
    );
  }
}
