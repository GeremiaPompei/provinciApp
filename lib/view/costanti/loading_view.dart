import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provinciApp/view/costanti/costanti_assets.dart';
import 'package:provinciApp/view/stile/colore.dart';

/// LoadingView offre la vista della schermata di caricamento.
class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colore.chiaro,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            CostantiAssets.logo,
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
