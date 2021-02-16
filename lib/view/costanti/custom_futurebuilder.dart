import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/view/costanti/loading_view.dart';
import 'package:provinciApp/view/costanti/offline_view.dart';
import 'package:provinciApp/view/costanti/vuoto_view.dart';
import 'package:provinciApp/view/costanti/custom_appbar.dart';

/// CustomFutureBuilder fornisce un FutureBuilder personalizzato per provinciApp
/// che facilita il suo uso.
class CustomFutureBuilder extends StatefulWidget {
  /// Future del FutureBuilder.
  Future<dynamic> _future;

  /// Titolo dell'AppBar.
  String _titolo;

  /// Funzione che genera il Widget del corpo dello scaffold.
  Widget Function(dynamic) _corpo;

  CustomFutureBuilder(this._future, this._titolo, this._corpo);

  set title(String value) {
    _titolo = value;
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
            tmpWidget = widget._corpo(snapshot.data);
          else
            tmpWidget = VuotoView();
        } else if (snapshot.hasError) {
          tmpWidget = OfflineView();
        } else {
          tmpWidget = LoadingView();
        }
        return Scaffold(
          appBar: CustomAppBar(
            titolo: widget._titolo,
          ),
          body: tmpWidget,
        );
      },
    );
  }
}
