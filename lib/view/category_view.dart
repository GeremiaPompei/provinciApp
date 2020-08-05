import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:MC/model/http_request.dart';
import 'package:flutter/material.dart';

class categoryView extends StatefulWidget {
  @override
  _categoryViewState createState() => _categoryViewState();
}

class _categoryViewState extends State<categoryView> {
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
  categories().asStream().first.asStream().forEach((e) {
      result += e.toString() + '\n';
  });
  return result;
}
