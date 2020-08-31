import 'package:MC/utility/Style.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomeView.dart';

class BottomButtonDown extends StatefulWidget {
  void Function(int) _func;

  BottomButtonDown(this._func);

  @override
  _BottomButtonDownState createState() =>
      _BottomButtonDownState(this._func);
}

class _BottomButtonDownState extends State<BottomButtonDown> {
  void Function(int) _func;

  _BottomButtonDownState(this._func);

  void onItemTapped(index) {
    setState(() {
      _func(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: ThemePrimaryColor,
      backgroundColor: BackgroundColor,
      buttonBackgroundColor: ThemeSecondaryColor,
      items: <Widget>[
        Icon(Icons.home),
        Icon(Icons.event),
        Icon(Icons.free_breakfast),
        Icon(Icons.file_download)
      ],
      animationDuration: Duration(milliseconds: 500),
      animationCurve: Curves.fastOutSlowIn,
      onTap: onItemTapped,
    );
  }
}
