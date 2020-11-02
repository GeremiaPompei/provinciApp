import 'package:flutter/cupertino.dart';
import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/model/cache/unit_cache.dart';
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
  /// Funzione che genera la ListaUnitCacheView.
  Widget _generaListaUnitCacheView(
          List<MapEntry<String, UnitCache>> _list,
          Future<dynamic> Function(String name, String url, int image)
              _funcFuture,
          Widget Function(String name) _funcWidget,
          BuildContext context) =>
      _list.isEmpty
          ? Container()
          : ListaUnitCacheView(_list, _funcFuture, _funcWidget);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _generaListaUnitCacheView(
              widget._controller.pacchetti
                  .where((element) => element.value.elemento.isNotEmpty)
                  .toList(),
              widget._controller.cercaFromUrl,
              (name) => ListaPacchettiView(widget._controller),
              context),
          SizedBox(
            height: 20,
          ),
          _generaListaUnitCacheView(
              widget._controller.risorse
                  .where((element) => element.value.elemento.isNotEmpty)
                  .toList(),
              widget._controller.cercaRisorse,
              (name) => ListaRisorseView(
                  widget._controller, widget._controller.ultimeRisorse),
              context),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
