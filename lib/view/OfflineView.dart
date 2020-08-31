import 'package:MC/utility/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OfflineView extends StatefulWidget {
  @override
  _OfflineViewState createState() => _OfflineViewState();
}

class _OfflineViewState extends State<OfflineView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: RaisedButton(
                child: Text('Offline', style: TitleTextStyle_20),
                color: BackgroundColor,
                elevation: 6,
                onPressed: () {
                  setState(() {
                    Navigator.pushNamedAndRemoveUntil(context, '/offline',
                        (route) => route.popped == null);
                  });
                })));
  }
}
