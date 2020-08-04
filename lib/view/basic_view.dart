import 'package:flutter_html/flutter_html.dart';

import 'package:MC/model/http_request.dart';
import 'package:flutter/material.dart';

MaterialApp mtrApp() =>
  MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
            'MC Search...'
        ),
      ),
      body: press(),
    ),
);

class press extends StatefulWidget {
  @override
  _pressState createState() => _pressState();
}

class _pressState extends State<press> {
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
                  fetchWord(text).asStream().any((element) {
                    element.forEach((e) {
                      result += e.toString()+'\n';
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
