import 'package:provinciApp/controller/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/view/pacchetto_view/pacchetto_view.dart';
import 'package:provinciApp/view/stile/colore.dart';

/// ListaPacchettiView da la vista personalizzata di una lista di pacchetti.
class ListaPacchettiView extends StatefulWidget {
  Controller _controller;

  ListaPacchettiView(this._controller);

  @override
  _ListaPacchettiViewState createState() => _ListaPacchettiViewState();
}

class _ListaPacchettiViewState extends State<ListaPacchettiView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colore.chiaro,
      body: ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 28),
        itemCount: widget._controller.ultimiPacchetti.length,
        itemBuilder: (context, index) => PacchettoView(
            widget._controller, widget._controller.ultimiPacchetti[index]),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
