import 'package:MC/view/HomeView.dart';
import 'package:flutter/material.dart';
import 'controller/Controller.dart';

void main() {
  Controller controller = new Controller();
  return runApp(MaterialApp(home: HomeView(controller)));
}
