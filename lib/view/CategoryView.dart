import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:MC/model/HttpRequest.dart';
import 'package:flutter/material.dart';

class categoryView extends StatefulWidget {
  @override
  _categoryViewState createState() => _categoryViewState();
}

class _categoryViewState extends State<categoryView> {
  String result = '';

  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            TextField(
              onSubmitted: (String input) {
                setState(() {});
              },
            ),
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                setState(() {
                  result = '';
                  categories().asStream().any((element) {
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
