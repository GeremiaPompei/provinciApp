import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

/// ListaInfoView offre una vista di una lista di informazioni.
class ListaInfoView extends StatefulWidget {
  /// Informazioni da mostrare.
  Map<String, String> _info;

  ListaInfoView(this._info);

  @override
  _ListaInfoViewState createState() => _ListaInfoViewState();
}

class _ListaInfoViewState extends State<ListaInfoView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      itemCount: widget._info.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(
          widget._info.keys.toList()[index],
        ),
        subtitle: Linkify(
          text: '${widget._info.values.toList()[index]}',
          onOpen: (LinkableElement link) async {
            if (await canLaunch(widget._info.values.toList()[index]))
              await launch(widget._info.values.toList()[index]);
          },
        ),
      ),
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
