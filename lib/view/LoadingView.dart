import 'package:MC/utility/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      body: Center(
        child: Container(
          child: Stack(
            overflow: Overflow.clip,
            alignment: Alignment.center,
            children: [
              Image(
                image:
                AssetImage("assets/logo_mc.PNG"),
                height: 200,
              ),
              SpinKitCubeGrid(
                size: 200,
                color: BackgroundColor,
                duration: Duration(milliseconds: 1000),
              ),
            ],
          ),
        ),
      ),
    );
  }
}