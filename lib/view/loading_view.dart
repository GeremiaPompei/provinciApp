import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provinciApp/utility/stile/colore.dart';

/// LoadingView offre la vista della schermata di caricamento.
class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("assets/logo_mc.PNG"),
            height: 180,
          ),
          SpinKitCubeGrid(
            color: Colore.primario,
            duration: Duration(milliseconds: 1000),
          ),
        ],
      ),
    );
  }
}
