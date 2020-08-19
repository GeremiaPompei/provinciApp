import 'dart:io';

import 'package:MC/view/HomeView.dart';
import 'package:flutter/material.dart';
import 'controller/Controller.dart';

void main() {
  Controller controller = new Controller();
  Widget varWidget;
  return runApp(MaterialApp(
    home: FutureBuilder<dynamic>(
      future: controller.init(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData)
          varWidget = HomeView(controller);
        else
          //TODO sostituire Scaffold con Widget per immagini di caricamento
          varWidget = Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        return varWidget;
      },
    ),
  ));
}
