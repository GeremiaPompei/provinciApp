import 'package:MC/controller/Controller.dart';
import 'package:MC/utility/Style.dart';
import 'package:MC/view/SavedView.dart';
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
    return Flex(direction: Axis.vertical, children: <Widget>[
      Flexible(
          child: ListView(
        children: [
          Card(
              child: ListTile(
            title: Text('Eventi'),
            trailing: Icon(Icons.event_available),
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
                                  varWidget = EventiView(this._controller);
                                else if (snapshot.hasError)
                                  varWidget = Scaffold(
                                      appBar: AppBar(
                                        title: Text(
                                          'Eventi',
                                          style: TitleTextStyle,
                                        ),
                                        backgroundColor: BackgroundColor,
                                      ),
                                      body: OfflineView());
                                else
                                  varWidget = LoadingView();
                                return varWidget;
                              },
                            )));
              });
            },
          )),
          Card(
            child: ListTile(
                title: Text('Promo'),
                trailing: Icon(Icons.monetization_on),
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
                                      varWidget = PromoView(this._controller);
                                    else if (snapshot.hasError)
                                      varWidget = Scaffold(
                                          appBar: AppBar(
                                            title: Text(
                                              'Promo',
                                              style: TitleTextStyle,
                                            ),
                                            backgroundColor: BackgroundColor,
                                          ),
                                          body: OfflineView());
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
    ]);
  }
}
