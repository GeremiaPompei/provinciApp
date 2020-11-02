import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/model/pacchetto.dart';
import 'package:provinciApp/view/costanti/costanti_assets.dart';
import 'package:provinciApp/utility/stile/icona.dart';
import 'package:provinciApp/utility/stile/stiletesto.dart';
import 'package:provinciApp/view/custom/custom_futurebuilder.dart';
import 'package:provinciApp/view/pacchetto_view/lista_pacchetti_view.dart';

/// CategoriaView offre la vista di una singola categoria.
class CategoriaView extends StatefulWidget {
  Controller _controller;

  /// Categoria da mostrare.
  Pacchetto _categoria;

  CategoriaView(this._controller, this._categoria);

  @override
  _CategoriaViewState createState() => _CategoriaViewState();
}

class _CategoriaViewState extends State<CategoriaView> {
  /// Widget rappresentante l'immagine di una categoria vuota.
  Widget _categoriaImmagineVuota = Image.asset(CostantiAssets.categoriaVuota);

  /// Widget rappresentantel'immagine della categoria.
  Widget _immagine(dynamic image) => image == null
      ? this._categoriaImmagineVuota
      : Image(
          image: NetworkImage(image),
          errorBuilder: (context, widget, imageCheckEvent) =>
              this._categoriaImmagineVuota,
        );

  @override
  Widget build(BuildContext context) {
    return new Stack(children: <Widget>[
      new Container(
        margin: new EdgeInsets.only(left: 43.5),
        child: Card(
          child: widget._categoria == null
              ? null
              : FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomFutureBuilder(
                          widget._controller.cercaFromUrl(
                              widget._categoria.nome,
                              widget._categoria.url,
                              Icona.categorie),
                          widget._categoria.nome,
                          ListaPacchettiView(widget._controller),
                        ),
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      widget._categoria.nome.toString(),
                      style: StileTesto.corpo,
                    ),
                  ),
                ),
        ),
      ),
      if (widget._categoria != null)
        new Container(
            margin: new EdgeInsets.symmetric(vertical: 10.0),
            alignment: FractionalOffset.centerLeft,
            child: _immagine(widget._categoria.immagineUrl)),
    ]);
  }
}
