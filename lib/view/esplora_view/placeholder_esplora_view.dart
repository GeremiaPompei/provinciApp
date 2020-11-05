import 'package:flutter/cupertino.dart';
import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/view/pacchetto_view/lista_pacchetti_view.dart';
import 'package:provinciApp/view/risorsa_view/lista_risorse_view.dart';
import 'package:provinciApp/view/unitcache_view/lista_unitcache_view.dart';

/// PlaceHolderEsploraView rappresentante il placeHolder dell'EsploraView.
class PlaceHolderEsploraView extends StatefulWidget {
  Controller _controller;

  PlaceHolderEsploraView(this._controller);

  @override
  _PlaceHolderEsploraViewState createState() => _PlaceHolderEsploraViewState();
}

class _PlaceHolderEsploraViewState extends State<PlaceHolderEsploraView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 20),
        child: Column(
          children: [
            ListaUnitCacheView(
                widget._controller.pacchetti
                    .where((element) => element.value.elemento.isNotEmpty)
                    .toList(),
                widget._controller.cercaFromUrl,
                ListaPacchettiView(widget._controller),
                context),
            ListaUnitCacheView(
                widget._controller.risorse
                    .where((element) => element.value.elemento.isNotEmpty)
                    .toList(),
                widget._controller.cercaRisorse,
                ListaRisorseView(
                    widget._controller, widget._controller.ultimeRisorse),
                context),
          ],
        ),
      ),
    );
  }
}
