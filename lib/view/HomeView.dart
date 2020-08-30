import 'package:MC/controller/Controller.dart';
import 'package:MC/utility/style.dart';
import 'package:MC/view/BottomButtonBar.dart';
import 'package:MC/view/DetailedLeafInfoView.dart';
import 'package:MC/view/EsploraView.dart';
import 'package:MC/view/EventiView.dart';
import 'package:MC/view/LeafsInfoView.dart';
import 'package:MC/view/LoadingView.dart';
import 'package:MC/view/OfflineWidget.dart';
import 'package:MC/view/SalvatiView.dart';
import 'package:MC/view/ScrollListView.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'PromoView.dart';

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
  Future offlineF;
  Future esploraF;
  Future eventiF;
  Future promoF;
  Icon cusIcon = Icon(Icons.search, size: 30, color: ThemePrimaryColor);

  _HomeViewState(this.controller) {
    this.offlineF = this.controller.initOffline();
    this.esploraF = this.controller.init();
    this.eventiF = this.controller.initEvents();
    this.promoF = this.controller.initPromos();
    this.title = 'Esplora';
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
    setState(
      () {
        switch (index) {
          case 0:
            this.title = 'Esplora';
            this.varWidget = initWidgetFuture(
                () => this.esploraF, EsploraView(this.controller));
            break;
          case 1:
            this.title = 'Eventi';
            this.varWidget = initWidgetFuture(
                () => this.eventiF, EventiView(this.controller));
            break;
          case 2:
            this.title = 'Promo';
            this.varWidget =
                initWidgetFuture(() => this.promoF, PromoView(this.controller));
            break;
          case 3:
            this.title = 'Salvati';
            this.varWidget = initWidgetFuture(
                () => this.offlineF, SalvatiView(this.title, this.controller));
            break;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BackgroundColor,
        brightness: Brightness.light,
        title: Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: TitleTextStyle,
            )),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right:10.0),
                child: IconButton(
                    alignment: Alignment.topRight,
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
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
      body: varWidget,
      bottomNavigationBar: BottomButtonDown(controller, onItemTapped),
    );
  }

  Future findPosition() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
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
