import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/model/pacchetto.dart';
import 'package:provinciApp/utility/stile/colore.dart';
import 'package:provinciApp/utility/stile/icona.dart';
import 'package:provinciApp/view/costanti/costanti_assets.dart';
import 'package:provinciApp/view/custom/custom_futurebuilder.dart';
import 'package:provinciApp/view/custom/custom_icon.dart';
import 'package:provinciApp/view/risorsa_view/lista_risorse_view.dart';

/// OnItemFoundEsploraView rappresentante l'onItemFound dell'EsploraView.
class OnItemFoundEsploraView extends StatefulWidget {
  Controller _controller;

  /// Pacchetto da mostrare.
  Pacchetto _pacchetto;

  OnItemFoundEsploraView(this._controller, this._pacchetto);

  @override
  _OnItemFoundEsploraViewState createState() => _OnItemFoundEsploraViewState();
}

class _OnItemFoundEsploraViewState extends State<OnItemFoundEsploraView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        isThreeLine: true,
        title: Text(widget._pacchetto.nome),
        subtitle: Text(widget._pacchetto.descrizione),
        leading: Stack(alignment: Alignment.center, children: [
          Image.asset(CostantiAssets.vuoto),
          CustomIcon(Icona.trovaIcona(widget._pacchetto.nome), Colore.chiaro),
        ]),
        onTap: () async {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => CustomFutureBuilder(
                widget._controller.cercaRisorse(
                  widget._pacchetto.nome,
                  widget._pacchetto.url,
                  Icona.trovaIcona(widget._pacchetto.nome),
                ),
                widget._pacchetto.nome,
                ListaRisorseView(
                    widget._controller, widget._controller.ultimeRisorse),
              ),
            ),
          )
              .then((value) {
            setState(() {
              (context as Element).reassemble();
            });
          });
        },
      ),
    );
  }
}
