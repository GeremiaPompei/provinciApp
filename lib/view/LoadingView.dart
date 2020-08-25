import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../style.dart';

class LoadingView extends StatelessWidget {
  //TODO widget loading
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('MACERATA', style: TitleTextStyle),
            Image(
              image: AssetImage("assets/images/Provincia_di_Macerata-Logo.png"),
              height: 200,
            ),
            SpinKitCubeGrid(
              color: ThemePrimaryColor,
              duration: Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }
}
