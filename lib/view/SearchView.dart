import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:MC/model/HttpRequest.dart';
import 'package:flutter/material.dart';

class searchView extends StatefulWidget {
  @override
  _searchViewState createState() => _searchViewState();
}

class _searchViewState extends State<searchView> {
  String text = '';
  String result = '';

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
                  searchByWord(text).asStream().any((element) {
                    element.forEach((e) {
                      result += e.toString() + '\n';
                    });
                    return true;
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