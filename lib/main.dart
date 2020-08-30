import 'package:MC/view/HomeView.dart';
import 'package:MC/view/OfflineView.dart';
import 'package:flutter/material.dart';
import 'controller/Controller.dart';

void main() {
  Controller controller = Controller();
  return runApp(MaterialApp(home: HomeView(controller), routes: {
    '/online': (context) => HomeView(controller),
    '/offline': (context) => OfflineWidget(controller),
  }));
}
