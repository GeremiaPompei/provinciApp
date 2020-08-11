import 'package:MC/controller/Controller.dart';
import 'package:MC/model/LeafInfo.dart';
import 'package:MC/model/LeafsInfo/AreeCamper.dart';
import 'package:MC/model/LeafsInfo/Bando.dart';
import 'package:MC/model/LeafsInfo/Biblioteca.dart';
import 'package:MC/model/LeafsInfo/Concorso.dart';
import 'package:MC/model/LeafsInfo/Evento.dart';
import 'package:MC/model/LeafsInfo/Monumento.dart';
import 'package:MC/model/LeafsInfo/Museo.dart';
import 'package:MC/model/LeafsInfo/Shopping.dart';
import 'package:MC/model/LeafsInfo/Struttura.dart';
import 'package:MC/model/LeafsInfo/Teatro.dart';
import 'package:MC/view/BasicView.dart';
import 'package:MC/view/LeafsInfoView.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  Controller controller;

  SearchView(this.controller);

  @override
  _SearchViewState createState() => _SearchViewState(controller);
}

class _SearchViewState extends State<SearchView> {
  Controller controller;

  _SearchViewState(this.controller);

  void visual(int index,
      LeafInfo Function(Map<String, dynamic> parsedJson) func) {
    controller
        .setLeafInfo(controller.getSearch()[index].url, (el) => func(el))
        .then((value) =>
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LeafsInfoView(controller.getLeafs(),
                          controller.getSearch()[index].name, controller)
                          .launch(context)));
        }));
  }

  int length() {
    if (controller.getSearch() != null)
      return controller
          .getSearch()
          .length;
    else
      return 0;
  }

  void setLeafs(int index) {
    setState(() {
      String name = controller.getSearch()[index].name.toString();
      if (name.contains('Concorsi'))
        visual(index, (parsedJson) => Concorso.fromJson(parsedJson));
      else if (name.contains('Bandi'))
        visual(index, (parsedJson) => Bando.fromJson(parsedJson));
      else if (name.contains('Strutture') || name.contains('Case'))
        visual(index, (parsedJson) => Struttura.fromJson(parsedJson));
      else if (name.contains('Shopping'))
        visual(index, (parsedJson) => Shopping.fromJson(parsedJson));
      else if (name.contains('Musei'))
        visual(index, (parsedJson) => Museo.fromJson(parsedJson));
      else if (name.contains('Monumenti') ||
          name.contains('Chiese') ||
          name.contains('Rocche'))
        visual(index, (parsedJson) => Monumento.fromJson(parsedJson));
      else if (name.contains('Teatri'))
        visual(index, (parsedJson) => Teatro.fromJson(parsedJson));
      else if (name.contains('Biblioteche'))
        visual(index, (parsedJson) => Biblioteca.fromJson(parsedJson));
      else if (name.contains('Eventi'))
        visual(index, (parsedJson) => Evento.fromJson(parsedJson));
      else if (name.contains('Aree'))
        visual(index, (parsedJson) => AreeCamper.fromJson(parsedJson));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.search),
          ),
          onSubmitted: (String input) {
            setState(() {
              controller.setSearch('dataset?q=' + input).then((value) =>
                  Launcher().launch('MC Search...', SearchView(controller),
                      controller: controller));
            });
          },
        ),
        Flexible(
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: length(),
            itemBuilder: (context, index) {
              return FlatButton(
                child: ListTile(
                  title: Text(controller.getSearch()[index].name.toString()),
                  subtitle: Text(
                      controller.getSearch()[index].description.toString()),
                ),
                onPressed: () {
                  setLeafs(index);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
            const Divider(),
          ),
        ),
      ],
    );
  }
}
