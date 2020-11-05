import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/view/stile/icona.dart';
import 'package:provinciApp/view/costanti//custom_futurebuilder.dart';
import 'pacchetto_view/lista_pacchetti_view.dart';

/// PosizioneView offre la vista della ricerca dei pacchetti tramite la
/// geolocalizzazione.
class PosizioneView extends StatefulWidget {
  Controller _controller;

  PosizioneView(this._controller);

  @override
  _PosizioneViewState createState() => _PosizioneViewState();
}

class _PosizioneViewState extends State<PosizioneView> {
  /// CustomFutureBuilder utile per modificare il titolo dell'appBar quando
  /// viene trovato il nome della posizione.
  CustomFutureBuilder _customFutureBuilder;

  @override
  void initState() {
    _customFutureBuilder = CustomFutureBuilder(
      _cercaFromPosizione(),
      'Posizione',
      (list) => ListaPacchettiView(list),
    );
  }

  /// Metodo utile per cercare pacchetti in base alla posizione.
  Future<dynamic> _cercaFromPosizione() async {
    String location = await widget._controller.cercaPosizione();
    _customFutureBuilder.title = location;
    return await widget._controller.cercaFromParola(location, Icona.posizione);
  }

  @override
  Widget build(BuildContext context) => _customFutureBuilder;
}
