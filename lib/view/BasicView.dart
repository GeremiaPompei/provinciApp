import 'package:MC/controller/Controller.dart';
import 'package:MC/view/OrganizationView.dart';
import 'package:MC/view/SearchView.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'CategoryView.dart';

void mtrApp() {
  Launcher().launch(
      'MC Start...',
      Center(
          child: Text(
        'Start...',
        style: TextStyle(fontSize: 40),
      )));
}

class ButtonBarDown extends StatefulWidget {
  Controller controller;
  void Function(String title, Widget widget) launch;
  ButtonBarDown(this.controller,this.launch);

  @override
  _ButtonBarDownState createState() => _ButtonBarDownState(controller,launch);
}

class _ButtonBarDownState extends State<ButtonBarDown> {
  Controller controller;
  void Function(String title, Widget widget) launch;

  _ButtonBarDownState(this.controller,this.launch);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: ButtonBar(
        children: <Widget>[
          FlatButton(
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                launch('MC Search..', searchView(controller));
              },
            ),
          ),
          FlatButton(
            child: IconButton(
              icon: Icon(Icons.location_city),
              onPressed: () {
                launch('MC Organizations...', organizationView(controller));
              },
            ),
          ),
          FlatButton(
            child: IconButton(
              icon: Icon(Icons.category),
              onPressed: () {
                launch('MC Category...', categoryView(controller));
              },
            ),
          ),
          FlatButton(
            child: IconButton(
              icon: Icon(Icons.comment),
              onPressed: () {
                launch('MC Comment...', Center(child: Icon(Icons.comment)));
              },
            ),
          ),
          FlatButton(
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                launch('MC Settings...', Center(child: Icon(Icons.settings)));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Launcher {

  Controller controller;
  ButtonBarDown bar;

  Launcher(){
    this.controller = new Controller();
    this.bar = new ButtonBarDown(controller,launch);
  }

  void launch(String title, Widget widget) {
    runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(title),
        ),
        body: widget,
        bottomNavigationBar: bar,
      ),
    ));
  }
}