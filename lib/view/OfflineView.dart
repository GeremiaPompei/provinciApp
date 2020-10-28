import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/utility/stile/colore.dart';
import 'package:provinciApp/utility/stile/stiletesto.dart';

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
        color: Colore.sfondo,
        child: Center(
            child: RaisedButton(
                child: Text('Offline', style: StileTesto.sottotitolo),
                color: Colore.chiaro,
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
                  color: Colore.primario,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                this._name,
                style: StileTesto.titoloPrimario,
              ),
              backgroundColor: Colore.chiaro,
            ),
            body: getBody());
  }
}
