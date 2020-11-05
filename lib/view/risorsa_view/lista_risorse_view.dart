import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/model/risorsa.dart';
import 'package:provinciApp/view/stile/colore.dart';
import 'package:provinciApp/view/risorsa_view/risorsa_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// ListaRisorseView da la vista personalizzata di una lista di risorse.
class ListaRisorseView extends StatefulWidget {
  Controller _controller;

  /// Funzione di aggiornamento delle risorse.
  Function(dynamic) _update;

  /// Lista delle risorse.
  List<Risorsa> _risorse;

  ListaRisorseView(this._controller, this._risorse, {Function update}) {
    this._update = update;
  }

  @override
  _ListaRisorseViewState createState() => _ListaRisorseViewState();
}

class _ListaRisorseViewState extends State<ListaRisorseView> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colore.sfondo,
      child: SmartRefresher(
        enablePullDown: widget._update == null ? false : true,
        header: ClassicHeader(),
        controller: _refreshController,
        onRefresh: () => widget._update(_refreshController),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: widget._risorse.length,
          itemBuilder: (context, index) =>
              RisorsaView(widget._controller, widget._risorse[index]),
        ),
      ),
    );
  }
}
