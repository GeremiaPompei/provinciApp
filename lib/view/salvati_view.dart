import 'package:provinciApp/controller/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/view/stile/colore.dart';
import 'package:provinciApp/view/stile/icona.dart';
import 'package:provinciApp/view/risorsa_view/lista_risorse_view.dart';
import 'costanti/custom_appbar.dart';
import 'costanti/custom_icon.dart';

/// SalvatiView offre la vista delle risorse salvate offline.
class SalvatiView extends StatefulWidget {
  Controller _controller;

  SalvatiView(this._controller);

  @override
  _SalvatiViewState createState() => _SalvatiViewState();
}

class _SalvatiViewState extends State<SalvatiView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        primaSchermata: true,
        title: 'Offline',
        actions: [
          IconButton(
            icon: CustomIcon(Icona.online, Colore.chiaro),
            onPressed: () async {
              Navigator.pushReplacementNamed(context, '/online');
            },
          ),
        ],
      ),
      body: ListaRisorseView(
        widget._controller,
        widget._controller.offline,
        update: (_refreshController) => setState(() {
          widget._controller.initOffline().then((value) {
            (context as Element).reassemble();
            _refreshController.refreshCompleted();
          });
        }),
      ),
    );
  }
}
