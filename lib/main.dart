import 'package:MC/view/HomeView.dart';
import 'package:MC/view/SavedView.dart';
import 'package:flutter/material.dart';
import 'controller/Controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Controller controller = Controller();
  await controller.initLoadAndStore();
  await controller.initCategories();
  await controller.initOrganizations();
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
