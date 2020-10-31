import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/model/pacchetto.dart';
import 'package:provinciApp/utility/stile/colore.dart';
import 'package:provinciApp/utility/stile/icona.dart';
import 'package:provinciApp/utility/stile/stiletesto.dart';
import 'custom/custom_futurebuilder.dart';
import 'lista_pacchetti_view.dart';

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
  Widget _comuneImmagineVuoto;

  @override
  void initState() {
    this._comuneImmagineVuoto = Container(
      height: 55,
      width: 55,
      child: Image.asset('assets/logo_mc.PNG'),
    );
  }

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
          ? null
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
                          ListaPacchettiView(widget._controller),
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
