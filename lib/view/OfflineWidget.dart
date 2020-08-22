import 'package:MC/controller/Controller.dart';
import 'package:MC/view/HomeView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OfflineWidget extends StatefulWidget {
  Controller controller;

  OfflineWidget(this.controller);

  @override
  _OfflineWidgetState createState() => _OfflineWidgetState(this.controller);
}

class _OfflineWidgetState extends State<OfflineWidget> {
  Controller controller;

  _OfflineWidgetState( this.controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 150,
            ),
            Text(
              'OFFLINE',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'StencilArmyWWI',
              ),
            ),
            FlatButton(
              color: Colors.red,
              child: Text(
                'Ricarica',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  this.controller.initEvents();
                  this.controller.initPromos();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
