import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/model/cache/unit_cache.dart';
import 'package:provinciApp/utility/stile/colore.dart';
import 'package:provinciApp/utility/stile/stiletesto.dart';
import 'package:provinciApp/view/costanti/costanti_assets.dart';
import 'package:provinciApp/view/custom/custom_futurebuilder.dart';
import 'package:provinciApp/view/custom/custom_icon.dart';

/// UnitCacheView fornisce la vista uìdi una singola UnitCache.
class UnitCacheView extends StatefulWidget {
  /// MapEntry rappresenta una singola entry con chiave stringa e valore la
  /// unitCache rappresentata.
  MapEntry<String, UnitCache> _mapEntry;

  /// Funzione ritornante il future della UnitCache.
  Future<dynamic> Function(String name, String url, int image) _funcFuture;

  /// Funzione ritornante il widget della UnitCache.
  Widget Function(String name) _funcWidget;

  UnitCacheView(this._mapEntry, this._funcFuture, this._funcWidget);

  @override
  _UnitCacheViewState createState() => _UnitCacheViewState();
}

class _UnitCacheViewState extends State<UnitCacheView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colore.chiaro,
      child: FlatButton(
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
                  widget._funcWidget(widget._mapEntry.value.nome),
                ),
              ),
            ).then((value) {
              setState(() {
                (context as Element).reassemble();
              });
            });
          });
        },
      ),
    );
  }
}
