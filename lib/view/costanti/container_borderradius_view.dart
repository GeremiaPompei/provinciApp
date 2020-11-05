import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/view/stile/colore.dart';
import 'package:provinciApp/view/stile/stiletesto.dart';

/// ContainerBorderRadiusView da la vista di un container personalizzato con
/// bordi arrotondati e colore di sfondo chiaro dove è possibile mostrare
/// all'interno un titolo ed un widget o solo un widget.
class ContainerBorderRadiusView extends StatefulWidget {
  /// Titolo da mostrare.
  String _titolo;

  /// Widget da mostrare.
  Widget _widget;

  ContainerBorderRadiusView(this._widget, {String titolo}) {
    this._titolo = titolo;
  }

  @override
  _ContainerBorderRadiusViewState createState() =>
      _ContainerBorderRadiusViewState();
}

class _ContainerBorderRadiusViewState extends State<ContainerBorderRadiusView> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colore.chiaro,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: ListTile(
          title: widget._titolo == null
              ? null
              : Text(
                  widget._titolo,
                  style: StileTesto.sottotitolo,
                ),
          subtitle: widget._widget,
        ),
      ),
    ]);
  }
}
