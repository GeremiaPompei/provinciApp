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
        child: ElevatedButton(
            child: Text('Offline', style: StileTesto.titoloChiaro),
            // color: Colore.primario,
            // elevation: 6,
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
