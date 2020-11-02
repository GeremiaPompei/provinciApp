import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/view/costanti/loading_view.dart';
import 'package:provinciApp/view/costanti/offline_view.dart';
import 'package:provinciApp/view/costanti/vuoto_view.dart';
import 'package:provinciApp/view/custom/custom_appbar.dart';

/// CustomFutureBuilder fornisce un FutureBuilder personalizzato per provinciApp
/// che facilita il suo uso.
class CustomFutureBuilder extends StatefulWidget {
  /// Future del FutureBuilder.
  Future<dynamic> _future;

  /// Titolo dell'AppBar.
  String _title;

  /// Widget del corpo dello scaffold.
  Widget _corpo;

  CustomFutureBuilder(this._future, this._title, this._corpo);

  set title(String value) {
    _title = value;
  }

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
        if (snapshot.hasData) {
          if (snapshot.data.isNotEmpty)
            tmpWidget = widget._corpo;
          else
            tmpWidget = VuotoView();
        } else if (snapshot.hasError) {
          tmpWidget = OfflineView();
        } else {
          tmpWidget = LoadingView();
        }
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
