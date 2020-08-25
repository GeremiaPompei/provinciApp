import 'package:MC/controller/Controller.dart';
import 'package:MC/view/BottomButtonBar.dart';
import 'package:MC/view/EsploraView.dart';
import 'package:MC/view/EventiView.dart';
import 'package:MC/view/LoadingView.dart';
import 'package:MC/view/OfflineWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

import '../style.dart';
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
  String location;
  String title;
  Widget varWidget;
  Future esploraF;
  Future eventiF;
  Future promoF;
  Icon cusIcon = Icon(Icons.search, size: 30, color: ThemePrimaryColor);
  Widget appBarTitle = new Text(
    "McApp",
    textAlign: TextAlign.left,
    style: TitleTextStyle,
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
        backgroundColor: BackgroundColor,
        elevation: 0,
        title: Align(alignment: Alignment.topLeft, child: appBarTitle),
        actions: [
          Row(
            children: [
              IconButton(
                //padding: EdgeInsets.only(right: 30),
                icon: cusIcon,
                color: ThemePrimaryColor,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  setState(
                    () {
                      if (this.cusIcon.icon == Icons.search) {
                        this.cusIcon = Icon(Icons.cancel,
                            color: ThemePrimaryColor, size: 20);
                        this.appBarTitle = new TextField(
                          cursorColor: Colors.red,
                          style: new TextStyle(
                            color: ThemePrimaryColor,
                            fontFamily: "Poppins",
                            fontSize: 25,
                          ),
                          decoration: new InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              hintText: "Cerca...",
                              hintStyle: TitleTextStyle_20),
                          onSubmitted: (String input) {
                            setState(
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FutureBuilder<dynamic>(
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
                        this.cusIcon = Icon(
                          Icons.search,
                          color: ThemePrimaryColor,
                          size: 30,
                        );
                        this.appBarTitle = new Text(
                          "McApp",
                          textAlign: TextAlign.left,
                          style: TitleTextStyle,
                        );
                      }
                    },
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.location_on,
                  color: ThemePrimaryColor,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FutureBuilder<dynamic>(
                                future: findPosition(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData)
                                    varWidget = ScrollListView(
                                        this.controller, this.location);
                                  else
                                    varWidget = LoadingView();
                                  return varWidget;
                                },
                              )));
                },
              ),
            ],
          ),
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

  Future findPosition() async {
    final Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager;
    Position position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    List<Placemark> placemark =
    await geolocator.placemarkFromPosition(position);
    this.location = placemark[0].locality;
    return this
        .controller
        .setSearch(this.location, 'dataset?q=' + this.location);
  }
}
