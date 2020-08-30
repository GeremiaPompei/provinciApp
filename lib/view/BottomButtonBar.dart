import 'package:MC/controller/Controller.dart';
import 'package:MC/utility/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'HomeView.dart';

class BottomButtonDown extends StatefulWidget {
  Controller controller;
  void Function(int) func;

  BottomButtonDown(this.controller, this.func);

  @override
  _BottomButtonDownState createState() =>
      _BottomButtonDownState(this.controller, this.func);
}

class _BottomButtonDownState extends State<BottomButtonDown> {
  Controller controller;
  int index = 0;
  void Function(int) func;

  _BottomButtonDownState(this.controller, this.func);

  void onItemTapped(index) {
    setState(() {
      this.index = index;
      func(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar (
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
