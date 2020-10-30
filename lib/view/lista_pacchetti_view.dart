import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/model/pacchetto.dart';
import 'package:provinciApp/utility/stile/colore.dart';
import 'package:provinciApp/utility/stile/icona.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom/custom_futurebuilder.dart';
import 'custom/custom_icon.dart';
import 'lista_risorse_view.dart';

/// ListaPacchettiView da la vista personalizzata di una lista di pacchetti.
class ListaPacchettiView extends StatefulWidget {
  Controller _controller;

  ListaPacchettiView(this._controller);

  @override
  _ListaPacchettiViewState createState() => _ListaPacchettiViewState();
}

class _ListaPacchettiViewState extends State<ListaPacchettiView> {
  /// Lista dei pacchetti visualizzati.
  List<Pacchetto> _pacchetti;

  @override
  void initState() {
    this._pacchetti = widget._controller.ultimiPacchetti;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: this._pacchetti.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            this._pacchetti[index].nome,
            maxLines: 2,
          ),
          subtitle: Text(
            this._pacchetti[index].descrizione.toString(),
            maxLines: 2,
          ),
          leading: Stack(alignment: Alignment.center, children: [
            Image.asset('assets/empty.png'),
            CustomIcon(
              Icona.trovaIcona(this._pacchetti[index].nome),
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
                      _pacchetti[index].nome,
                      _pacchetti[index].url,
                      Icona.trovaIcona(_pacchetti[index].nome),
                    ),
                    _pacchetti[index].nome,
                    ListaRisorseView(
                        widget._controller, widget._controller.ultimeRisorse),
                  ),
                ),
              );
            });
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
