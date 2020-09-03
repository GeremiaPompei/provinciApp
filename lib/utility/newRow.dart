import 'package:MC/utility/cardThumbnail.dart';
import 'package:MC/utility/listCard.dart';
import 'package:flutter/material.dart';

class newRow extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        child: new Stack(
          children: <Widget>[
            listCard, // TODO questa invece il titolo e vari dati
            cardThumbnail, //TODO questa dovrebbe prendere immagine
          ],
        ),);
  }
}
