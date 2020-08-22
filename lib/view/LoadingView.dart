import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  //TODO widget loading
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(height: 150,),
            Text(
              'MACERATA',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'StencilArmyWWI',
              ),
            ),
            CircularProgressIndicator(),
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
