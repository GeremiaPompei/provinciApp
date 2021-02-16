import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:map_launcher/map_launcher.dart' as mapLauncher;
import 'package:provinciApp/view/stile/colore.dart';
import 'package:provinciApp/view/stile/icona.dart';
import 'package:provinciApp/view/costanti/custom_icon.dart';
import 'package:provinciApp/view/costanti/menumappa_view.dart';

/// IconButtonPosizioneView offre la vista di un bottone utile per visualizzare
/// una posizione all'interno di un'applicazione mappe esterna.
class IconButtonPosizioneView extends StatefulWidget {
  /// Posizione da mostrare sotto forma di latitudine e longitudine.
  List<double> _posizione;

  /// Nome della posizione.
  String _nome;

  IconButtonPosizioneView(this._posizione, this._nome);

  @override
  _IconButtonPosizioneViewState createState() =>
      _IconButtonPosizioneViewState();
}

class _IconButtonPosizioneViewState extends State<IconButtonPosizioneView> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colore.chiaro,
      child: IconButton(
        onPressed: () async {
          try {
            mapLauncher.Coords coordinate =
                mapLauncher.Coords(widget._posizione[0], widget._posizione[1]);
            String nome = widget._nome;
            List<mapLauncher.AvailableMap> mappe =
                await MapLauncher.installedMaps;
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return MenuMappaView(coordinate, nome, mappe);
              },
            );
          } catch (e) {}
        },
        icon: CustomIcon(
          Icona.posizione,
          Colore.scuro,
        ),
      ),
    );
  }
}
