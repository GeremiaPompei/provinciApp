import 'package:MC/utility/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingView extends StatelessWidget {
  bool _image;

  LoadingView({bool image}) {
    this._image = image == null ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor2,
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
                color: PrimaryColor,
                duration: Duration(milliseconds: 1000),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
