import 'package:MC/controller/Controller.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class categoryView extends StatefulWidget {
  Controller controller;

  categoryView(this.controller);

  @override
  _categoryViewState createState() => _categoryViewState(controller);
}

class _categoryViewState extends State<categoryView> {
  String result = '';
  Controller controller;

  _categoryViewState(this.controller);

  void onPressed() {
    setState(() {
      result = '';
      controller.getCategories().forEach((e) {
        result += e.toString() + '\n';
      });
    });
  }

  Widget build(BuildContext context) {
    onPressed();
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
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
