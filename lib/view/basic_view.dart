import 'package:MC/view/organization_view.dart';
import 'package:MC/view/search_view.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:MC/model/http_request.dart';
import 'package:flutter/material.dart';

import 'category_view.dart';

MaterialApp mtrApp() {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('MC Start...'),
      ),
      bottomNavigationBar: buttonBar(),
    ),
  );
}

class buttonBar extends StatefulWidget {
  @override
  _buttonBarState createState() => _buttonBarState();
}

class _buttonBarState extends State<buttonBar> {
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
                launch('MC Search..', searchView());
              },
            ),
          ),
          FlatButton(
            child: IconButton(
              icon: Icon(Icons.location_city),
              onPressed: () {
                launch('MC Organizations...', organizationView());
              },
            ),
          ),
          FlatButton(
            child: IconButton(
              icon: Icon(Icons.category),
              onPressed: () {
                launch('MC Category...', categoryView());
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

void launch(String title, Widget widget) {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(title),
      ),
      body: widget,
      bottomNavigationBar: buttonBar(),
    ),
  ));
}
