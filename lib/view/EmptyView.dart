import 'package:provinciApp/utility/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatefulWidget {
  String _title;

  EmptyView(this._title);

  @override
  _EmptyViewState createState() => _EmptyViewState(this._title);
}

class _EmptyViewState extends State<EmptyView> {
  String _title;
  Widget _body = Center(
    child: Text(
      'Vuoto',
      style: TitleTextStyle,
      textAlign: TextAlign.center,
    ),
  );

  _EmptyViewState(this._title);

  @override
  Widget build(BuildContext context) {
    return this._title == null
        ? _body
        : Scaffold(
            appBar: AppBar(
              title: Text(
                _title,
                style: ReverseTitleTextStyle,
              ),
              backgroundColor: PrimaryColor,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: BackgroundColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: _body,
          );
  }
}
