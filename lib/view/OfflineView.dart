import 'package:MC/utility/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OfflineView extends StatefulWidget {
  String _name;

  OfflineView(this._name);

  @override
  _OfflineViewState createState() => _OfflineViewState(this._name);
}

class _OfflineViewState extends State<OfflineView> {
  String _name;

  _OfflineViewState(this._name);

  Widget getBody() {
    return Container(
        color: BackgroundColor2,
        child: Center(
            child: RaisedButton(
                child: Text('Offline', style: TitleTextStyle_20),
                color: BackgroundColor,
                elevation: 6,
                onPressed: () {
                  setState(() {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/offline', (route) => route.popped == null);
                  });
                })));
  }

  @override
  Widget build(BuildContext context) {
    return this._name == null
        ? getBody()
        : Scaffold(
            appBar: AppBar(
              brightness: Brightness.light,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: PrimaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                this._name,
                style: TitleTextStyle,
              ),
              backgroundColor: BackgroundColor,
            ),
            body: getBody());
  }
}
