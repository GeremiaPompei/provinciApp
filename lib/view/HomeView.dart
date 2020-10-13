import 'package:MC/controller/Controller.dart';
import 'package:MC/utility/ConstUrl.dart';
import 'package:MC/utility/Style.dart';
import 'package:MC/view/BottomButtonBar.dart';
import 'package:MC/view/CategorieView.dart';
import 'package:MC/view/EsploraView.dart';
import 'package:MC/view/ExtraView.dart';
import 'package:MC/view/OfflineView.dart';
import 'package:MC/view/OrganizationsView.dart';
import 'package:MC/view/LoadingView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'EmptyView.dart';
import 'ScrollListView.dart';

class HomeView extends StatefulWidget {
  Controller _controller;
  int _index;

  HomeView(this._controller, this._index);

  @override
  _HomeViewState createState() => _HomeViewState(_controller, this._index);
}

class _HomeViewState extends State<HomeView> {
  Controller _controller;
  String _title;
  Widget _varWidget;
  Future _esploraF;
  Future _organizationsF;
  Future _categoriesF;
  String _location;
  int _index;

  _HomeViewState(this._controller, this._index) {
    this._esploraF = this._controller.initLoadAndStore();
    this._categoriesF = this._controller.initCategories();
    this._organizationsF = this._controller.initOrganizations();
    init(this._index);
  }

  Future _findPosition() async {
    await this._controller.tryConnection();
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    Position position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    List<Placemark> placemark =
        await geolocator.placemarkFromPosition(position);
    this._location = placemark[0].locality;
    return this._controller.setSearch(
        this._location, MCDATASET_SEARCH + this._location, IconPosition);
  }

  Widget initWidgetFuture(Future<dynamic> Function() func, Widget input) =>
      FutureBuilder<dynamic>(
        future: func(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Widget tmpWidget;
          if (snapshot.hasData)
            tmpWidget = input;
          else if (snapshot.hasError)
            tmpWidget = OfflineView(null);
          else
            tmpWidget = LoadingView();
          return tmpWidget;
        },
      );

  void init(index) async {
    this._index = index;
    switch (index) {
      case 0:
        this._title = 'Comuni';
        this._varWidget = initWidgetFuture(
            () => this._organizationsF, OrganizationsView(this._controller));
        break;
      case 1:
        this._title = 'Esplora';
        this._varWidget = initWidgetFuture(
            () => this._esploraF, EsploraView(this._controller));
        break;
      case 2:
        this._title = 'Categorie';
        this._varWidget = initWidgetFuture(
            () => this._categoriesF, CategoriesView(this._controller));
        break;
    }
  }

  void onItemTapped(index) async {
    setState(() {
      init(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor2,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: BackgroundColor,
        title: Text(
          _title,
          style: TitleTextStyle,
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.extension_rounded,
                color: PrimaryColor,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: BackgroundColor,
                    content: Container(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      child: ExtraView(this._controller),
                    ),
                    actions: [
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Indietro',
                            style: TitleDetaileStyle,
                          ))
                    ],
                  ),
                );
              }),
          IconButton(
            color: PrimaryColor,
            icon: Icon(
              IconData(IconPosition, fontFamily: 'MaterialIcons'),
              color: PrimaryColor,
            ),
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FutureBuilder<dynamic>(
                      future: _findPosition(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        Widget varWidget;
                        if (snapshot.hasData) if (snapshot.data.isNotEmpty)
                          varWidget =
                              ScrollListView(this._controller, this._location);
                        else
                          varWidget = Scaffold(
                            body: EmptyView(this._location),
                          );
                        else if (snapshot.hasError)
                          varWidget = OfflineView('Find Position');
                        else
                          varWidget = LoadingView();
                        return varWidget;
                      },
                    ),
                  ),
                ).then((value) {
                  setState(() {
                    (context as Element).reassemble();
                  });
                });
              });
            },
          ),
          IconButton(
            color: PrimaryColor,
            icon: Icon(Icons.file_download),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/offline');
            },
          ),
        ],
      ),
      body: _varWidget,
      bottomNavigationBar: Material(
        elevation: 8.0,
        child: Container(
          color: BackgroundColor,
          padding: EdgeInsets.only(top: 10),
          child: BottomButtonDown(onItemTapped, this._index),
        ),
      ),
    );
  }
}
