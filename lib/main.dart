import 'package:provinciApp/view/HomeView.dart';
import 'package:provinciApp/view/LoadingView.dart';
import 'package:provinciApp/view/SavedView.dart';
import 'package:flutter/material.dart';
import 'controller/controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Controller controller = Controller();
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: controller.initController(),
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
      },
    ),
  );
}
