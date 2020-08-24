import 'package:MC/controller/Controller.dart';
import 'package:MC/view/EsploraView.dart';
import 'package:MC/view/EventiView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('Esplora'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          title: Text('Eventi'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.free_breakfast),
          title: Text('Promo'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.save_alt),
          title: Text('Salvati'),
        ),
      ],
      unselectedItemColor: Colors.black,
      currentIndex: index,
      selectedItemColor: Colors.red,
      onTap: onItemTapped,
    );
  }
}
