import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/view/stile/colore.dart';
import 'package:provinciApp/view/stile/icona.dart';
import 'package:provinciApp/view/costanti/custom_icon.dart';
import 'package:share/share.dart';

/// IconButtonShareView offre la vista di un bottone utile per condividere una
/// stringa tramite altre applicazioni.
class IconButtonShareView extends StatefulWidget {
  /// Stringa da condividere.
  String _toShare;

  IconButtonShareView(this._toShare);

  @override
  _IconButtonShareViewState createState() => _IconButtonShareViewState();
}

class _IconButtonShareViewState extends State<IconButtonShareView> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colore.chiaro,
      child: IconButton(
        icon: CustomIcon(
          Icona.condividi,
          Colore.scuro,
        ),
        onPressed: () {
          setState(() {
            final RenderBox box = context.findRenderObject();
            Share.share(widget._toShare,
                sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
          });
        },
      ),
    );
  }
}
