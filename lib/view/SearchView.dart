import 'package:MC/controller/Controller.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:MC/model/HttpRequest.dart';
import 'package:flutter/material.dart';

class searchView extends StatefulWidget {

  Controller controller;

  searchView(this.controller);

  @override
  _searchViewState createState() => _searchViewState(controller);
}

class _searchViewState extends State<searchView> {
  String text = '';
  String result = '';
  Controller controller;

  _searchViewState(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            TextField(
              onSubmitted: (String input) {
                setState(() {
                  text = input;
                });
              },
            ),
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                setState(() {
                  result = '';
                  controller.setSearch(text);
                  controller.getSearch().forEach((e) {
                    result += e.toString() + '\n';
                  });
                });
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  '$result',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}