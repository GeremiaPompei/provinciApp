import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/model/risorsa.dart';
import 'package:provinciApp/view/stile/colore.dart';
import 'package:provinciApp/view/stile/icona.dart';
import 'package:provinciApp/view/costanti/custom_icon.dart';

/// AppBarDettaglioRisorsaView offre la vista della SliverAppBar della vista del
/// dettaglio della risorsa.
class AppBarDettaglioRisorsaView extends StatefulWidget {
  Controller _controller;

  /// Risorsa della quale si ha il dettaglio e sulla quale si opera.
  Risorsa _risorsa;

  AppBarDettaglioRisorsaView(this._risorsa, this._controller);

  @override
  _AppBarDettaglioRisorsaViewState createState() =>
      _AppBarDettaglioRisorsaViewState();
}

class _AppBarDettaglioRisorsaViewState
    extends State<AppBarDettaglioRisorsaView> {
  /// Icona dell'aggiunta o rimozione della risorsa nella lista delle risorse
  /// offline.
  CustomIcon _icona;

  @override
  void initState() {
    widget._controller.offline.contains(widget._risorsa)
        ? this._icona = CustomIcon(Icona.rimuoviOffline, Colore.chiaro)
        : this._icona = CustomIcon(Icona.salvaOffline, Colore.chiaro);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      backgroundColor: Colore.primario,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colore.chiaro,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: this._icona,
          onPressed: () {
            setState(() {
              if (widget._controller.offline.contains(widget._risorsa)) {
                widget._controller.removeOffline(widget._risorsa);
                this._icona = CustomIcon(Icona.salvaOffline, Colore.chiaro);
              } else {
                widget._controller.addOffline(widget._risorsa);
                this._icona = CustomIcon(Icona.rimuoviOffline, Colore.chiaro);
              }
            });
          },
        )
      ],
    );
  }
}
