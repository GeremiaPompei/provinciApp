import 'package:MC/controller/Controller.dart';
import 'package:MC/view/BottomButtonBar.dart';
import 'package:MC/view/EsploraView.dart';
import 'package:MC/view/EventiView.dart';
import 'package:MC/view/LoadingView.dart';
import 'package:MC/view/OfflineWidget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return SafeArea(
      child: Scaffold(
        /*appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          title,
          style: GoogleFonts.poppins(
              color: Colors.red, fontWeight: FontWeight.w900),
        ),
      ),*/
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, top: 45),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "ESPLORA",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: varWidget,
              ),
            ],
          ),
          bottomNavigationBar: BottomButtonDown(controller, onItemTapped)),
    );
  }
}
