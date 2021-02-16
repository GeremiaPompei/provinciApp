import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provinciApp/view/stile/colore.dart';
import 'package:provinciApp/view/stile/icona.dart';
import 'package:latlong/latlong.dart';
import 'package:provinciApp/view/costanti/custom_icon.dart';

/// MappaView offre la vista di una certa area geografica in una mappa.
class MappaView extends StatefulWidget {
  /// Posizione da mostrare.
  List<double> _posizione;

  MappaView(this._posizione);

  @override
  _MappaViewState createState() => _MappaViewState();
}

class _MappaViewState extends State<MappaView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      alignment: Alignment.centerLeft,
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(widget._posizione[0], widget._posizione[1]),
          zoom: 13.0,
        ),
        layers: [
          new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(widget._posizione[0], widget._posizione[1]),
                builder: (ctx) => Container(
                  child: CustomIcon(
                    Icona.posizione,
                    Colore.scuro,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
