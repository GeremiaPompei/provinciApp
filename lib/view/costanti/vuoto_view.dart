import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/utility/stile/stiletesto.dart';

/// VuotoView informa quando un elemento ricercato non presenta altri elementi
/// all'interno.
class VuotoView extends StatefulWidget {
  @override
  _VuotoViewState createState() => _VuotoViewState();
}

class _VuotoViewState extends State<VuotoView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Vuoto',
        style: StileTesto.titoloPrimario,
        textAlign: TextAlign.center,
      ),
    );
  }
}
