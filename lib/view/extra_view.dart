import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/utility/costanti/costanti_web.dart';
import 'package:provinciApp/utility/stile/colore.dart';
import 'package:provinciApp/utility/stile/stiletesto.dart';
import 'package:url_launcher/url_launcher.dart';

/// ExtraView è la vista che mostra i diversi extra da selezionare e quando uno
/// di questo viene pigiato si viene reindirizzato al loro sito web.
class ExtraView extends StatefulWidget {
  @override
  _ExtraViewState createState() => _ExtraViewState();
}

class _ExtraViewState extends State<ExtraView> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colore.chiaro,
      content: Container(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: CostantiWeb.urlsExtra.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      CostantiWeb.urlsExtra[index].nome,
                      style: StileTesto.sottotitolo,
                    ),
                    subtitle: Text(
                      CostantiWeb.urlsExtra[index].descrizione,
                      style: StileTesto.corpo,
                    ),
                    trailing: Image(
                      image: NetworkImage(
                          CostantiWeb.urlsExtra[index].immagineUrl),
                    ),
                    onTap: () {
                      launch(CostantiWeb.urlsExtra[index].url);
                    },
                  );
                }),
          )),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Indietro',
              style: StileTesto.sottotitolo,
            ))
      ],
    );
  }
}
