import 'package:MC/controller/Controller.dart';
import 'package:flutter/material.dart';

Controller _controller;
final cardThumbnail = new Container(
  margin: new EdgeInsets.symmetric(vertical: 10.0),
  alignment: FractionalOffset.centerLeft,
  child: Image(
    image:AssetImage("assets/empty.png"),
    height: 100.0,
    width: 100.0,
  ),
);
