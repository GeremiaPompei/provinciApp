import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/model/pacchetto.dart';
import 'package:provinciApp/view/costanti/costanti_assets.dart';
import 'package:provinciApp/view/stile/colore.dart';
import 'package:provinciApp/view/stile/icona.dart';
import 'package:provinciApp/view/stile/stiletesto.dart';
import 'package:provinciApp/view/costanti/custom_futurebuilder.dart';
import 'package:provinciApp/view/pacchetto_view/lista_pacchetti_view.dart';

/// ComuneView offre la vista di un singolo comune.
class ComuneView extends StatefulWidget {
  Controller _controller;

  /// Comune da mostrare.
  Pacchetto _comune;

  ComuneView(this._controller, this._comune);

  @override
  _ComuneViewState createState() => _ComuneViewState();
}

class _ComuneViewState extends State<ComuneView> {
  /// Widget rappresentante l'immagine di un comune vuoto.
  Widget _comuneImmagineVuoto = Image.asset(CostantiAssets.comuneVuoto);

  /// Widget rappresentantel'immagine del comune.
  Widget _immagine(dynamic image) => image == null
      ? this._comuneImmagineVuoto
      : Image(
          image: NetworkImage(image),
          errorBuilder: (context, widget, imageCheckEvent) =>
              this._comuneImmagineVuoto,
        );

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colore.chiaro,
      child: widget._comune == null
          ? Container()
          : Stack(children: [
              FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        height: 65,
                        child: _immagine(widget._comune.immagineUrl)),
                    Center(
                      child: Text(
                        widget._comune.nome,
                        style: StileTesto.corpo,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomFutureBuilder(
                          widget._controller.cercaFromUrl(widget._comune.nome,
                              widget._comune.url, Icona.comuni),
                          widget._comune.nome,
                          (list) => ListaPacchettiView(widget._controller),
                        ),
                      ),
                    );
                  });
                },
              ),
            ]),
    );
  }
}
