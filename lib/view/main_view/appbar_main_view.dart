import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/utility/stile/colore.dart';
import 'package:provinciApp/utility/stile/icona.dart';
import 'package:provinciApp/view/custom/custom_icon.dart';
import 'package:provinciApp/view/extra_view/lista_extra_view.dart';
import 'package:provinciApp/view/posizione_view.dart';
import 'package:provinciApp/view/custom/custom_appbar.dart';

/// AppBarMainView è l'appBar della mainView che mostra il titolo della
/// sottoVista e offre pulsanti per funzionalità aggiuntive come accesso ad
/// attività extra, ricerca di pacchetti tramite localizzazione e accesso a
/// risorse offline.
class AppBarMainView extends StatefulWidget implements PreferredSizeWidget {
  Controller _controller;

  /// Titolo della sottoView.
  String _title;

  AppBarMainView(this._controller, this._title);

  @override
  _AppBarMainViewState createState() => _AppBarMainViewState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _AppBarMainViewState extends State<AppBarMainView> {
  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      primaSchermata: true,
      sfondoChiaro: true,
      title: widget._title,
      actions: [
        IconButton(
            icon: CustomIcon(
              Icona.extra,
              Colore.primario,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => ListaExtraView(widget._controller),
              );
            }),
        IconButton(
          color: Colore.primario,
          icon: CustomIcon(Icona.posizione, Colore.primario),
          onPressed: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PosizioneView(widget._controller),
                ),
              ).then((value) {
                setState(() {
                  (context as Element).reassemble();
                });
              });
            });
          },
        ),
        IconButton(
          color: Colore.primario,
          icon: CustomIcon(Icona.offline, Colore.primario),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/offline');
          },
        ),
      ],
    );
  }
}
