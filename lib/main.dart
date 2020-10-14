import 'package:MC/utility/PhoneNumberParser.dart';
import 'package:MC/view/HomeView.dart';
import 'package:MC/view/SavedView.dart';
import 'package:flutter/material.dart';
import 'controller/Controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Controller controller = Controller();
  return runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(
        controller,
        1,
      ),
      routes: {
        '/online': (context) => HomeView(controller, 1),
        '/offline': (context) => SavedWidget(controller),
      }));
}
