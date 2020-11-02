import 'package:provinciApp/view/main_view/main_view.dart';
import 'package:provinciApp/view/costanti/loading_view.dart';
import 'package:provinciApp/view/salvati_view.dart';
import 'package:flutter/material.dart';
import 'controller/controller.dart';

/// Metodo main da dove viene lanciata l'applicazione provinciApp.
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
            tmpWidget = MainView(
              controller,
              1,
            );
          else if (snapshot.hasError) {
            tmpWidget = LoadingView();
            print(snapshot.error);
          } else
            tmpWidget = LoadingView();
          return tmpWidget;
        },
      ),
      routes: {
        '/online': (context) => MainView(controller, 1),
        '/offline': (context) => SalvatiView(controller),
      },
    ),
  );
}
