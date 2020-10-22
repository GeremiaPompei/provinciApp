import 'package:provinciApp/controller/Controller.dart';
import 'package:provinciApp/utility/Style.dart';
import 'package:provinciApp/view/SavedView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'EventiView.dart';
import 'LoadingView.dart';
import 'OfflineView.dart';
import 'PromoView.dart';

class ExtraView extends StatefulWidget {
  Controller _controller;

  ExtraView(this._controller);

  @override
  _ExtraViewState createState() => _ExtraViewState(this._controller);
}

class _ExtraViewState extends State<ExtraView> {
  Controller _controller;
  Future _eventsF;
  Future _promosF;

  _ExtraViewState(this._controller) {
    this._eventsF = this._controller.initEvents();
    this._promosF = this._controller.initPromos();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8),
        child: Flex(direction: Axis.vertical, children: <Widget>[
          Flexible(
              child: ListView(
            children: [
              Card(
                  color: PrimaryColor,
                  child: ListTile(
                    title: Text('Eventi',style: ReverseTitleTextStyle),
                    leading: Icon(
                      Icons.event_available,
                      color: BackgroundColor,
                      size: 35,
                    ),
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FutureBuilder<dynamic>(
                                      future: this._eventsF,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        Widget varWidget;
                                        if (snapshot.hasData)
                                          varWidget =
                                              EventiView(this._controller);
                                        else if (snapshot.hasError)
                                          varWidget = OfflineView('Eventi');
                                        else
                                          varWidget = LoadingView();
                                        return varWidget;
                                      },
                                    )));
                      });
                    },
                  )),
              Card(
                color: PrimaryColor,
                child: ListTile(
                    title: Text('Promo',style: ReverseTitleTextStyle,),
                    leading: Icon(
                      Icons.monetization_on,
                      color: BackgroundColor,
                      size: 35,
                    ),
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FutureBuilder<dynamic>(
                                      future: this._promosF,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        Widget varWidget;
                                        if (snapshot.hasData)
                                          varWidget =
                                              PromoView(this._controller);
                                        else if (snapshot.hasError)
                                          varWidget = OfflineView('Promo');
                                        else
                                          varWidget = LoadingView();
                                        return varWidget;
                                      },
                                    )));
                      });
                    }),
              ),
            ],
          ))
        ]));
  }
}
