import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingView extends StatelessWidget {
  //TODO widget loading
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'MACERATA',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'StencilArmyWWI',
              ),
            ),
            SpinKitCubeGrid(
              color: Colors.red,
              duration: Duration(milliseconds: 300),
            ),
            Image(
              image: AssetImage('assets/logo_mc.PNG'),
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
