import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/view/stile/colore.dart';
import 'package:provinciApp/view/stile/icona.dart';
import 'package:provinciApp/view/costanti/custom_icon.dart';
import 'package:url_launcher/url_launcher.dart';

/// IconButtonEmailView offre la vista di un bottone utile per inviare una mail.
class IconButtonEmailView extends StatefulWidget {
  /// Email del destinatario.
  String _email;

  IconButtonEmailView(this._email);

  @override
  _IconButtonEmailViewState createState() => _IconButtonEmailViewState();
}

class _IconButtonEmailViewState extends State<IconButtonEmailView> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colore.chiaro,
      child: IconButton(
        icon: CustomIcon(
          Icona.email,
          Colore.scuro,
        ),
        onPressed: () async {
          await launch('mailto:${widget._email}');
        },
      ),
    );
  }
}
