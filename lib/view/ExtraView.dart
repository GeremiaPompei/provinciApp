import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/utility/costanti/costanti_web.dart';
import 'package:provinciApp/utility/stile/stiletesto.dart';
import 'package:url_launcher/url_launcher.dart';

class ExtraView extends StatefulWidget {
  @override
  _ExtraViewState createState() => _ExtraViewState();
}

class _ExtraViewState extends State<ExtraView> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                image: NetworkImage(CostantiWeb.urlsExtra[index].immagineUrl),
              ),
              onTap: () {
                launch(CostantiWeb.urlsExtra[index].url);
              },
            );
          }),
    );
  }
}
