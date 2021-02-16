import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart' as mapLauncher;
import 'package:map_launcher/map_launcher.dart';

/// MenuMappaView offre la vista del menu che offre il collegamento alle
/// applicazioni delle mappe dove mostrare una posizione date le coordinate.
class MenuMappaView extends StatefulWidget {
  /// Coordinate da mostrare nell'applicazione scelta dall'utente.
  mapLauncher.Coords _coordinate;

  /// Nome della posizione da mostrare.
  String _nome;

  /// Applicazioni delle mappe disponibili.
  List<AvailableMap> _mappe;

  MenuMappaView(this._coordinate, this._nome, this._mappe);

  @override
  _MenuMappaViewState createState() => _MenuMappaViewState();
}

class _MenuMappaViewState extends State<MenuMappaView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          child: Wrap(
            children: <Widget>[
              for (var map in widget._mappe)
                ListTile(
                  onTap: () => map.showMarker(
                    coords: widget._coordinate,
                    title: widget._nome,
                  ),
                  title: Text(map.mapName),
                  leading: Image(
                    image: map.icon,
                    height: 30.0,
                    width: 30.0,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
