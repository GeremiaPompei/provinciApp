import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/model/cache/unit_cache.dart';
import 'package:provinciApp/view/unitcache_view/unitcache_view.dart';

/// ListaUnitCacheView da la vista personalizzata di una lista di UnitCache.
class ListaUnitCacheView extends StatefulWidget {
  /// Lista delle MapEntry contenenti una stringa e la corrispondente UnitCache.
  List<MapEntry<String, UnitCache>> _list;

  /// Funzione ritornante il future della UnitCache.
  Future<dynamic> Function(String name, String url, int image) _funcFuture;

  /// Widget della UnitCache.
  Widget _widget;

  /// Contesto del padre per l'aggiornamento.
  BuildContext _contextParent;

  ListaUnitCacheView(
      this._list, this._funcFuture, this._widget, this._contextParent);

  @override
  _ListaUnitCacheViewState createState() => _ListaUnitCacheViewState();
}

class _ListaUnitCacheViewState extends State<ListaUnitCacheView> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      scrollDirection: Axis.vertical,
      primary: false,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      crossAxisCount: 2,
      children: List.generate(
        widget._list.length,
        (i) => UnitCacheView(widget._list[i], widget._funcFuture,
            widget._widget, widget._contextParent),
      ),
    );
  }
}
