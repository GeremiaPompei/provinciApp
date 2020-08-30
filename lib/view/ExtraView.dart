import 'package:MC/controller/Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'EventiView.dart';
import 'LoadingView.dart';
import 'PromoView.dart';

class ExtraView extends StatefulWidget {
  Controller _controller;

  ExtraView(this._controller);

  @override
  _ExtraViewState createState() => _ExtraViewState(this._controller);
}

class _ExtraViewState extends State<ExtraView> {
  Controller _controller;

  _ExtraViewState(this._controller);

  @override
  Widget build(BuildContext context) {
    return Flex(direction: Axis.vertical, children: <Widget>[
      Flexible(
          child: ListView(
        children: [
          FlatButton(
            child: Text('Eventi'),
            onPressed: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FutureBuilder<dynamic>(
                              future: _controller.initEvents(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                Widget varWidget;
                                if (snapshot.hasData)
                                  varWidget = EventiView(this._controller);
                                else if (snapshot.hasError)
                                  Navigator.pushReplacementNamed(
                                      context, '/offline');
                                else
                                  varWidget = LoadingView();
                                return varWidget;
                              },
                            )));
              });
            },
          ),
          FlatButton(
              child: Text('Promo'),
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FutureBuilder<dynamic>(
                                future: _controller.initPromos(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  Widget varWidget;
                                  if (snapshot.hasData)
                                    varWidget = PromoView(this._controller);
                                  else if (snapshot.hasError)
                                    Navigator.pushReplacementNamed(
                                        context, '/offline');
                                  else
                                    varWidget = LoadingView();
                                  return varWidget;
                                },
                              )));
                });
              })
        ],
      ))
    ]);
  }
}
