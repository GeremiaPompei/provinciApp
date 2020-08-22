import 'package:MC/controller/Controller.dart';
import 'package:MC/view/BottomButtonBar.dart';
import 'package:MC/view/EsploraView.dart';
import 'package:MC/view/EventiView.dart';
import 'package:MC/view/LoadingView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'PromoView.dart';

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
  Map<String,bool> flags = {'Esplora': true, 'Eventi': true, 'Promo': true};

  Widget initWidgetFuture(Future<dynamic> Function() func, Widget input) {
    if(this.flags[this.title]){
      return FutureBuilder<dynamic>(
        future: func(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Widget tmpWidget;
          if (snapshot.hasData)
            tmpWidget = input;
          else if (snapshot.hasError)
            tmpWidget = Text('Offline');
          else
            tmpWidget = LoadingView();
          this.flags[this.title] = false;
          return tmpWidget;
        },
      );
    }else{
      return input;
    }
  }

  _HomeViewState(this.controller) {
    this.title = 'Esplora';
    this.varWidget = initWidgetFuture(
        () => this.controller.init(), EsploraView(this.controller));
  }

  void onItemTapped(index) async {
    setState(() {
      switch (index) {
        case 0:
          this.title = 'Esplora';
          this.varWidget = initWidgetFuture(
                  () => this.controller.init(), EsploraView(this.controller));
          break;
        case 1:
          this.title = 'Eventi';
          this.varWidget = initWidgetFuture(
                  () => this.controller.initEvents(), EventiView(this.controller));
          break;
        case 2:
          this.title = 'Promo';
          this.varWidget = initWidgetFuture(
                  () => this.controller.initPromos(), PromoView(this.controller));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'StencilArmyWWI',
          ),
        ),
      ),
      body: varWidget,
      bottomNavigationBar: BottomButtonDown(controller, onItemTapped),
    );
  }
}
