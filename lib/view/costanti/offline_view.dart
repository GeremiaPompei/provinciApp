import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/view/stile/colore.dart';
import 'package:provinciApp/view/stile/stiletesto.dart';

/// OfflineView offre la vista che informa dell'assenza di rete.
class OfflineView extends StatefulWidget {
  @override
  _OfflineViewState createState() => _OfflineViewState();
}

class _OfflineViewState extends State<OfflineView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colore.sfondo,
      child: Center(
        child: RaisedButton(
            child: Text('Offline', style: StileTesto.titoloPrimario),
            color: Colore.chiaro,
            elevation: 6,
            onPressed: () {
              setState(() {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/offline', (route) => route.popped == null);
              });
            }),
      ),
    );
  }
}
