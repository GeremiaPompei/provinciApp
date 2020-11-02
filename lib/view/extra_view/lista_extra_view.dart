import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/utility/stile/colore.dart';
import 'package:provinciApp/utility/stile/stiletesto.dart';
import 'package:provinciApp/view/extra_view/extra_view.dart';

/// ListaExtraView è la vista che mostra i diversi extra da visitare.
class ListaExtraView extends StatefulWidget {
  Controller _controller;

  ListaExtraView(this._controller);

  @override
  _ListaExtraViewState createState() => _ListaExtraViewState();
}

class _ListaExtraViewState extends State<ListaExtraView> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colore.chiaro,
      content: Container(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: widget._controller.extra.length,
              itemBuilder: (context, index) =>
                  ExtraView(widget._controller.extra[index]),
            ),
          )),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Indietro',
              style: StileTesto.sottotitolo,
            ))
      ],
    );
  }
}
