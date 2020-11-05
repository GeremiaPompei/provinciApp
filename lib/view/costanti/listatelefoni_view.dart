import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:provinciApp/view/stile/colore.dart';
import 'package:provinciApp/view/stile/icona.dart';
import 'custom_icon.dart';

/// ListaTelefoniView offre la vista di un elenco di numeri di telefono da poter
/// chiamare.
class ListaTelefoniView extends StatefulWidget {
  /// Elenco dei numeri di telefono.
  List<String> _telefoni;

  ListaTelefoniView(this._telefoni);

  @override
  _ListaTelefoniViewState createState() => _ListaTelefoniViewState();
}

class _ListaTelefoniViewState extends State<ListaTelefoniView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      itemCount: widget._telefoni.length,
      itemBuilder: (context, index) => FlatButton(
        onPressed: () async {
          await FlutterPhoneDirectCaller.callNumber(
              '${widget._telefoni[index]}');
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              CustomIcon(
                Icona.telefono,
                Colore.scuro,
              ),
              Text('${widget._telefoni[index]}')
            ],
          ),
        ),
      ),
    );
  }
}
