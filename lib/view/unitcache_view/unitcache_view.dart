import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/model/cache/unit_cache.dart';
import 'package:provinciApp/view/stile/colore.dart';
import 'package:provinciApp/view/stile/stiletesto.dart';
import 'package:provinciApp/view/costanti/costanti_assets.dart';
import 'package:provinciApp/view/costanti/custom_futurebuilder.dart';
import 'package:provinciApp/view/costanti/custom_icon.dart';

/// UnitCacheView fornisce la vista uìdi una singola UnitCache.
class UnitCacheView extends StatefulWidget {
  /// MapEntry rappresenta una singola entry con chiave stringa e valore la
  /// unitCache rappresentata.
  MapEntry<String, UnitCache> _mapEntry;

  /// Funzione ritornante il future della UnitCache.
  Future<dynamic> Function(String name, String url, int image) _funcFuture;

  /// Funzione ritornante il Widget della UnitCache.
  Widget Function(List<dynamic> _list) _widget;

  /// Contesto del padre per l'aggiornamento.
  BuildContext _contextParent;

  UnitCacheView(
      this._mapEntry, this._funcFuture, this._widget, this._contextParent);

  @override
  _UnitCacheViewState createState() => _UnitCacheViewState();
}

class _UnitCacheViewState extends State<UnitCacheView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colore.chiaro,
      child: ElevatedButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 65,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    CostantiAssets.vuoto,
                  ),
                  widget._mapEntry.value.icona == null
                      ? Image.asset(CostantiAssets.vuoto)
                      : CustomIcon(widget._mapEntry.value.icona, Colore.chiaro),
                ],
              ),
            ),
            Center(
              child: Text(
                widget._mapEntry.value.nome,
                style: StileTesto.corpo,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        onPressed: () {
          setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomFutureBuilder(
                  widget._funcFuture(widget._mapEntry.value.nome,
                      widget._mapEntry.key, widget._mapEntry.value.icona),
                  widget._mapEntry.value.nome,
                  (list) => widget._widget(list),
                ),
              ),
            ).then((value) {
              setState(() {
                (context as Element).reassemble();
                (widget._contextParent as Element).reassemble();
              });
            });
          });
        },
      ),
    );
  }
}
