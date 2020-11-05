import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/model/pacchetto.dart';
import 'package:provinciApp/view/stile/stiletesto.dart';
import 'package:url_launcher/url_launcher.dart';

/// ExtraView è la vista che mostra un extra. Quando questo viene pigiato si
/// viene reindirizzato al proprio sito web.
class ExtraView extends StatefulWidget {
  /// Pacchetto contenente l'entra.
  Pacchetto _extra;

  ExtraView(this._extra);

  @override
  _ExtraViewState createState() => _ExtraViewState();
}

class _ExtraViewState extends State<ExtraView> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget._extra.nome,
        style: StileTesto.sottotitolo,
      ),
      subtitle: Text(
        widget._extra.descrizione,
        style: StileTesto.corpo,
      ),
      trailing: Image(
        image: NetworkImage(widget._extra.immagineUrl),
      ),
      onTap: () {
        launch(widget._extra.url);
      },
    );
  }
}
