import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/utility/stile/colore.dart';
import 'package:provinciApp/utility/stile/icona.dart';
import 'package:provinciApp/view/costanti/vuoto_view.dart';
import 'package:provinciApp/view/costanti/loading_view.dart';
import 'package:provinciApp/view/esplora_view/onitmefound_esplora_view.dart';
import 'package:provinciApp/view/esplora_view/placeholder_esplora_view.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/view/custom/custom_icon.dart';

/// EsploraView rappresenta la sottovista  contenente le UnitCache e la label
/// di ricerca.
class EsploraView extends StatefulWidget {
  Controller _controller;

  EsploraView(this._controller);

  @override
  _EsploraViewState createState() => _EsploraViewState();
}

class _EsploraViewState extends State<EsploraView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: SearchBar(
          searchBarStyle: SearchBarStyle(
            backgroundColor: Colore.chiaro,
            padding: EdgeInsets.all(6),
          ),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          icon: CustomIcon(Icona.cerca, Colore.primario),
          minimumChars: 1,
          placeHolder: PlaceHolderEsploraView(widget._controller),
          loader: LoadingView(),
          onSearch: (input) =>
              widget._controller.cercaFromParola(input, Icona.cerca),
          onError: (err) => VuotoView(),
          emptyWidget: VuotoView(),
          onItemFound: (input, num) =>
              OnItemFoundEsploraView(widget._controller, input),
        ),
      ),
    );
  }
}
