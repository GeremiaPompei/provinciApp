import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:MC/model/http_request.dart';
import 'package:flutter/material.dart';

class organizationView extends StatefulWidget {
  @override
  _organizationViewState createState() => _organizationViewState();
}

class _organizationViewState extends State<organizationView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text(
          str(),
        ),
      ),
    );
  }
}

String str(){
  String result = '';
  organizations().asStream().any((element) {
    element.forEach((e) {
      result += e.toString() + '\n';
      print(e.toString());
    });
    return true;
  });
  return result;
}
