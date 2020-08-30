import 'package:MC/controller/Controller.dart';
import 'package:MC/utility/Colore.dart';
import 'package:MC/utility/Font.dart';
import 'package:MC/view/BottomButtonBar.dart';
import 'package:MC/view/CategorieView.dart';
import 'package:MC/view/EsploraView.dart';
import 'package:MC/view/ExtraView.dart';
import 'package:MC/view/OrganizationsView.dart';
import 'package:MC/view/LoadingView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  Controller _controller;

  HomeView(this._controller);

  @override
  _HomeViewState createState() => _HomeViewState(_controller);
}

class _HomeViewState extends State<HomeView> {
  Controller _controller;
  String title;
  Widget varWidget;
  Future esploraF;
  Future organizationsF;
  Future categoriesF;

  _HomeViewState(this._controller) {
    this.esploraF = this._controller.initLoadAndStore();
    this.organizationsF = this._controller.initOrganizations();
    this.categoriesF = this._controller.initCategories();
    this.title = 'Esplora';
    this.varWidget = initWidgetFuture(() => this.esploraF, EsploraView(this._controller));
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

  void onItemTapped(index) async {
    setState(() {
      switch (index) {
        case 0:
          this.title = 'Esplora';
          this.varWidget =
              initWidgetFuture(() => this.esploraF, EsploraView(this._controller));
          break;
        case 1:
          this.title = 'Comuni';
          this.varWidget = initWidgetFuture(
              () => this.organizationsF,
              OrganizationsView(this._controller));
          break;
        case 2:
          this.title = 'Categorie';
          this.varWidget = initWidgetFuture(
              () => this.categoriesF,
              CategoriesView(this._controller));
          break;
        case 3:
          this.title = 'Extra';
          this.varWidget = ExtraView(this._controller);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colore.primario(),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: Font.primario(),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.offline_bolt),
            onPressed: () {
              setState(() {
                Navigator.pushReplacementNamed(context, '/offline');
              });
            },
          ),
        ],
      ),
      body: varWidget,
      bottomNavigationBar: BottomButtonDown(_controller, onItemTapped),
    );
  }
}
