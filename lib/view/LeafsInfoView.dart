import 'package:MC/controller/Controller.dart';
import 'package:MC/model/LeafInfo.dart';
import 'package:flutter/material.dart';

import 'BasicView.dart';
import 'SearchView.dart';

class LeafsInfoView {
  List<LeafInfo> leafs;
  String title;
  Controller controller;

  LeafsInfoView(this.leafs, this.title, this.controller);

  void launch() {
    runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text(title),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios),
              onPressed: () =>
                  {Launcher().launch('MC Search...', SearchView(controller))},
            ),
          ),
          body: ButtonInfo(leafs, title, controller),
        ),
      ),
    );
  }
}

class ButtonInfo extends StatefulWidget {
  List<LeafInfo> leafs;
  String title;
  Controller controller;

  ButtonInfo(this.leafs, this.title, this.controller);

  @override
  _ButtonInfoState createState() => _ButtonInfoState(leafs, title, controller);
}

class _ButtonInfoState extends State<ButtonInfo> {
  List<LeafInfo> leafs;
  String title;
  Controller controller;

  _ButtonInfoState(this.leafs, this.title, this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: leafs.length,
        itemBuilder: (context, index) {
          return FlatButton(
              child: ListTile(
                title: Text(leafs[index].getName()),
                subtitle: Text(leafs[index].getDescription()),
              ),
              onPressed: () {
                setState(() {
                  leafInfo(index);
                });
              });
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  void leafInfo(int index) {
    runApp(MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text(leafs[index].getName()),
              backgroundColor: Colors.red,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back_ios),
                onPressed: () {
                  LeafsInfoView(leafs, title, controller).launch();
                },
              ),
            ),
            body: Container(
                color: Colors.red,
                constraints: BoxConstraints.expand(),
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        leafs[index].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ))))));
  }
}
