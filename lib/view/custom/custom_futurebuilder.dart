import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../loading_view.dart';
import '../offline_view.dart';
import '../vuoto_view.dart';
import 'custom_appbar.dart';

class CustomFutureBuilder extends StatefulWidget {
  Future<dynamic> _future;
  String _title;
  Widget bodyVistaSuccessiva;

  CustomFutureBuilder(this._future, this._title, this.bodyVistaSuccessiva);

  @override
  _CustomFutureBuilderState createState() => _CustomFutureBuilderState();
}

class _CustomFutureBuilderState extends State<CustomFutureBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: widget._future,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        Widget tmpWidget;
        if (snapshot.hasData) if (snapshot.data.isNotEmpty)
          tmpWidget = widget.bodyVistaSuccessiva;
        else
          tmpWidget = VuotoView();
        else if (snapshot.hasError)
          tmpWidget = OfflineView();
        else
          tmpWidget = LoadingView();
        return Scaffold(
          appBar: CustomAppBar(
            title: widget._title,
          ),
          body: tmpWidget,
        );
      },
    );
  }
}
