import 'package:MC/controller/Controller.dart';
import 'package:MC/view/BottomButtonBar.dart';
import 'package:MC/view/EsploraView.dart';
import 'package:MC/view/EventiView.dart';
import 'package:MC/view/LoadingView.dart';
import 'package:MC/view/OfflineWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'PromoView.dart';
import 'ScrollListView.dart';

class HomeView extends StatefulWidget {
  Controller controller;

  HomeView(this.controller);

  @override
  _HomeViewState createState() => _HomeViewState(controller);
}

class _HomeViewState extends State<HomeView> {
  Controller controller;
  String title;
  Widget varWidget;
  Future esploraF;
  Future eventiF;
  Future promoF;
  Icon cusIcon = Icon(Icons.search, size: 30, color: Colors.red[600]);
  Widget appBarTitle = new Text(
    "McApp",
    textAlign: TextAlign.left,
    style: TextStyle(
      color: Colors.red,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w900,
      fontSize: 35,
    ),
  );

  _HomeViewState(this.controller) {
    this.esploraF = this.controller.init();
    this.eventiF = this.controller.initEvents();
    this.promoF = this.controller.initPromos();
    this.title = 'Home';
    this.varWidget =
        initWidgetFuture(() => this.esploraF, EsploraView(this.controller));
  }

  Widget initWidgetFuture(Future<dynamic> Function() func, Widget input) =>
      FutureBuilder<dynamic>(
        future: func(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Widget tmpWidget;
          if (snapshot.hasData)
            tmpWidget = input;
          else if (snapshot.hasError)
            tmpWidget = OfflineWidget(this.controller);
          else
            tmpWidget = LoadingView();
          return tmpWidget;
        },
      );

  void onItemTapped(index) async {
    setState(() {
      switch (index) {
        case 0:
          this.title = 'Home';
          this.varWidget = initWidgetFuture(
              () => this.esploraF, EsploraView(this.controller));
          break;
        case 1:
          this.title = 'Eventi';
          this.varWidget =
              initWidgetFuture(() => this.eventiF, EventiView(this.controller));
          break;
        case 2:
          this.title = 'Promo';
          this.varWidget =
              initWidgetFuture(() => this.promoF, PromoView(this.controller));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Align(alignment: Alignment.topLeft, child: appBarTitle),
        actions: [
          Row(children: [
            IconButton(
              padding: EdgeInsets.only(right: 30),
              icon: cusIcon,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                setState(
                  () {
                    if (this.cusIcon.icon == Icons.search) {
                      this.cusIcon =
                          Icon(Icons.cancel, color: Colors.red[600], size: 20);
                      this.appBarTitle = new TextField(
                        cursorColor: Colors.red,
                        style: new TextStyle(
                          color: Colors.red,
                          fontFamily: "Poppins",
                          fontSize: 25,
                        ),
                        decoration: new InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          hintText: "Search...",
                          hintStyle: new TextStyle(color: Colors.white),
                        ),
                        onSubmitted: (String input) {
                          setState(
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FutureBuilder<dynamic>(
                                    future: controller.setSearch(
                                        input, 'dataset?q=' + input),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<dynamic> snapshot) {
                                      if (snapshot.hasData)
                                        varWidget = ScrollListView(
                                            this.controller, input);
                                      else
                                        varWidget = LoadingView();
                                      return varWidget;
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else {
                      this.cusIcon =
                          Icon(Icons.search, color: Colors.red[600], size: 30);
                      this.appBarTitle = new Text(
                        "McApp",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w900,
                          fontSize: 35,
                        ),
                      );
                    }
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.location_on, color: Colors.red[600], size: 30),
            ),
          ]),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: varWidget,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomButtonDown(controller, onItemTapped),
    );
  }
}
