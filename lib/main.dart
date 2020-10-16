import 'package:MC/view/HomeView.dart';
import 'package:MC/view/LoadingView.dart';
import 'package:MC/view/SavedView.dart';
import 'package:flutter/material.dart';
import 'controller/Controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Controller controller = Controller();
  return runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: controller.initLoadAndStore(),
        builder: (context, snapshot) {
          Widget tmpWidget;
          if (snapshot.hasData)
            tmpWidget = HomeView(
              controller,
              1,
            );
          else
            tmpWidget = LoadingView();
          return tmpWidget;
        },
      ),
      routes: {
        '/online': (context) => HomeView(controller, 1),
        '/offline': (context) => SavedWidget(controller),
      }));
}
