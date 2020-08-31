import 'package:MC/controller/Controller.dart';
import 'package:MC/utility/Style.dart';
import 'package:MC/view/BottomButtonBar.dart';
import 'package:MC/view/CategorieView.dart';
import 'package:MC/view/EsploraView.dart';
import 'package:MC/view/ExtraView.dart';
import 'package:MC/view/OrganizationsView.dart';
import 'package:MC/view/LoadingView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'ScrollListView.dart';

class HomeView extends StatefulWidget {
  Controller _controller;

  HomeView(this._controller);

  @override
  _HomeViewState createState() => _HomeViewState(_controller);
}

class _HomeViewState extends State<HomeView> {
  Controller _controller;
  String _title;
  Widget _varWidget;
  Future _esploraF;
  Future _organizationsF;
  Future _categoriesF;
  String _location;

  _HomeViewState(this._controller) {
    this._esploraF = this._controller.initLoadAndStore();
    this._categoriesF = this._controller.initCategories();
    this._organizationsF = this._controller.initOrganizations();
    this._title = 'Esplora';
    this._varWidget =
        initWidgetFuture(() => this._esploraF, EsploraView(this._controller));
  }

  Widget initWidgetFuture(Future<dynamic> Function() func, Widget input) =>
      FutureBuilder<dynamic>(
        future: func(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Widget tmpWidget;
          if (snapshot.hasData)
            tmpWidget = input;
          else if (snapshot.hasError)
            Navigator.pushReplacementNamed(context, '/offline');
          else
            tmpWidget = LoadingView();
          return tmpWidget;
        },
      );

  Future findPosition() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    Position position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    List<Placemark> placemark =
    await geolocator.placemarkFromPosition(position);
    this._location = placemark[0].locality;
    return this
        ._controller
        .setSearch(this._location, 'dataset?q=' + this._location);
  }

  void onItemTapped(index) async {
    setState(() {
      switch (index) {
        case 0:
          this._title = 'Esplora';
          this._varWidget = initWidgetFuture(
              () => this._esploraF, EsploraView(this._controller));
          break;
        case 1:
          this._title = 'Comuni';
          this._varWidget = initWidgetFuture(
              () => this._organizationsF, OrganizationsView(this._controller));
          break;
        case 2:
          this._title = 'Categorie';
          this._varWidget = initWidgetFuture(
              () => this._categoriesF, CategoriesView(this._controller));
          break;
        case 3:
          this._title = 'Extra';
          this._varWidget = initWidgetFuture(
                  () => Future(()=>0), ExtraView(this._controller));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BackgroundColor,
        title: Text(
          _title,
          style: TitleTextStyle,
        ),
        actions: [
          IconButton(
            color: ThemePrimaryColor,
            icon: Icon(Icons.location_on),
            onPressed: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FutureBuilder<dynamic>(
                          future: findPosition(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            Widget varWidget;
                            if (snapshot.hasData)
                              varWidget = ScrollListView(
                                  this._controller, this._location);
                            else
                              varWidget = LoadingView();
                            return varWidget;
                          },
                        )));
              });
            },
          ),
          IconButton(
            color: ThemePrimaryColor,
            icon: Icon(Icons.offline_bolt),
            onPressed: () {
              setState(() {
                Navigator.pushReplacementNamed(context, '/offline');
              });
            },
          ),
        ],
      ),
      body: _varWidget,
      bottomNavigationBar: BottomButtonDown(onItemTapped),
    );
  }
}
