import 'package:MC/utility/Style.dart';
import 'package:flutter/material.dart';

final listCard = new Container(
  height: 124.0,
  margin: new EdgeInsets.only(left: 46.0),
  decoration: new BoxDecoration(
    color: ThemeSecondaryColor,
    shape: BoxShape.rectangle,
    borderRadius: new BorderRadius.circular(8.0),
    boxShadow: <BoxShadow>[
      new BoxShadow(
        color: Colors.black12,
        blurRadius: 10.0,
        offset: new Offset(0.0, 10.0),
      ),
    ],
  ),
);
