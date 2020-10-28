import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provinciApp/utility/stile/colore.dart';

class LoadingView extends StatelessWidget {
  bool _image;

  LoadingView({bool image}) {
    this._image = image == null ? true : image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colore.sfondo,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        leading: Container(),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              this._image
                  ? Image(
                      image: AssetImage("assets/logo_mc.PNG"),
                      height: 180,
                    )
                  : Container(),
              SpinKitCubeGrid(
                color: Colore.primario,
                duration: Duration(milliseconds: 1000),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
