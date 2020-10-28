import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/utility/stile/colore.dart';
import 'package:provinciApp/utility/stile/stiletesto.dart';

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
      style: StileTesto.titoloPrimario,
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
                style: StileTesto.titoloChiaro,
              ),
              backgroundColor: Colore.primario,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colore.chiaro,
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
