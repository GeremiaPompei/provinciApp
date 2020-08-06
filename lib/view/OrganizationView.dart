import 'package:MC/controller/Controller.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:MC/model/HttpRequest.dart';
import 'package:flutter/material.dart';

class organizationView extends StatefulWidget {
  Controller controller;

  organizationView(this.controller);

  @override
  _organizationViewState createState() => _organizationViewState(controller);
}

class _organizationViewState extends State<organizationView> {
  String result = '';
  Controller controller;

  _organizationViewState(this.controller);

  void onPressed(){
    setState(() {
      result = '';
      controller.getOrganizations().forEach((e) {
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
