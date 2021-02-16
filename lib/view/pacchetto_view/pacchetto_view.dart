import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/model/pacchetto.dart';
import 'package:provinciApp/view/costanti/costanti_assets.dart';
import 'package:provinciApp/view/stile/colore.dart';
import 'package:provinciApp/view/stile/icona.dart';
import 'package:provinciApp/view/costanti/custom_futurebuilder.dart';
import 'package:provinciApp/view/costanti/custom_icon.dart';
import 'package:provinciApp/view/risorsa_view/lista_risorse_view.dart';
import 'package:provinciApp/view/stile/stiletesto.dart';

/// PacchettoView da la vista personalizzata di un Pacchetto.
class PacchettoView extends StatefulWidget {
  Controller _controller;

  /// Pacchetto da mostrare.
  Pacchetto _pacchetto;

  PacchettoView(this._controller, this._pacchetto);

  @override
  _PacchettoViewState createState() => _PacchettoViewState();
}

class _PacchettoViewState extends State<PacchettoView> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget._pacchetto.nome,
        style: StileTesto.corpo,
        maxLines: 2,
      ),
      subtitle: Text(
        widget._pacchetto.descrizione.toString(),
        style: StileTesto.testo,
        maxLines: 2,
      ),
      leading: Stack(alignment: Alignment.center, children: [
        Image.asset(CostantiAssets.vuoto),
        CustomIcon(
          Icona.trovaIcona(widget._pacchetto.nome),
          Colore.chiaro,
        )
      ]),
      onTap: () {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomFutureBuilder(
                widget._controller.cercaRisorse(
                  widget._pacchetto.nome,
                  widget._pacchetto.url,
                  Icona.trovaIcona(widget._pacchetto.nome),
                ),
                widget._pacchetto.nome,
                (list) => ListaRisorseView(widget._controller, list),
              ),
            ),
          ).then((value) {
            setState(() {
              (context as Element).reassemble();
            });
          });
        });
      },
    );
  }
}
