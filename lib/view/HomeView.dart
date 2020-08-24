import 'package:MC/controller/Controller.dart';
import 'package:MC/view/BottomButtonBar.dart';
import 'package:MC/view/DetailedLeafInfoView.dart';
import 'package:MC/view/EsploraView.dart';
import 'package:MC/view/EventiView.dart';
import 'package:MC/view/LeafsInfoView.dart';
import 'package:MC/view/LoadingView.dart';
import 'package:MC/view/OfflineWidget.dart';
import 'package:MC/view/ScrollListView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  Future esploraF;
  Future eventiF;
  Future promoF;

  _HomeViewState(this.controller) {
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
    setState(() {
      switch (index) {
        case 0:
          this.title = 'Esplora';
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
        case 3:
          this.title = 'Salvati';
          this.varWidget = ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: this.controller.getOffline().length,
            itemBuilder: (context, index) {
              return Card(
                  child: FlatButton(
                      child: ListTile(
                        title: Text(
                            '${this.controller.getOffline()[index].getName()}'),
                        subtitle: this
                                    .controller
                                    .getOffline()[index]
                                    .getDescription() ==
                                null
                            ? Text('')
                            : Text(
                                '${this.controller.getOffline()[index].getDescription()}'),
                      ),
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailedLeafInfoView(
                                      title,
                                      this.controller.getOffline()[index],
                                      controller)));
                        });
                      }));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
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
