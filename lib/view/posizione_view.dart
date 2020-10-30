import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/utility/stile/icona.dart';
import 'custom/custom_futurebuilder.dart';
import 'lista_pacchetti_view.dart';

/// PosizioneView offre la vista della ricerca dei pacchetti tramite la
/// geolocalizzazione.
class PosizioneView extends StatefulWidget {
  Controller _controller;

  PosizioneView(this._controller);

  @override
  _PosizioneViewState createState() => _PosizioneViewState();
}

class _PosizioneViewState extends State<PosizioneView> {
  String _location;

  Future<dynamic> _cercaFromPosizione() async {
    this._location = await widget._controller.cercaPosizione();
    return widget._controller.cercaFromParola(this._location, Icona.posizione);
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      _cercaFromPosizione(),
      'Posizione',
      ListaPacchettiView(widget._controller),
    );
  }
}
