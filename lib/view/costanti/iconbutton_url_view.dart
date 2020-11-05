import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/view/stile/colore.dart';
import 'package:provinciApp/view/stile/icona.dart';
import 'package:provinciApp/view/costanti/custom_icon.dart';
import 'package:url_launcher/url_launcher.dart';

/// IconButtonUrlView offre la vista di un bottone utile per aprire un browser
/// su un certo url.
class IconButtonUrlView extends StatefulWidget {
  /// Url su cui aprire il browser.
  String _url;

  IconButtonUrlView(this._url);

  @override
  _IconButtonUrlViewState createState() => _IconButtonUrlViewState();
}

class _IconButtonUrlViewState extends State<IconButtonUrlView> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colore.chiaro,
      child: IconButton(
        icon: CustomIcon(
          Icona.link,
          Colore.scuro,
        ),
        onPressed: () {
          launch(widget._url);
        },
      ),
    );
  }
}
