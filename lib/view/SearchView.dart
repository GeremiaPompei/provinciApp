import 'package:MC/controller/Controller.dart';
import 'package:MC/model/LeafsType/Bando.dart';
import 'package:MC/model/LeafsType/Concorso.dart';
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

  void visual(int index){
    setState(() {
      LeafsInfoView(
          controller.getLeafs(),
          controller.getSearch()[index].name,
          controller)
          .launch();
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
            itemCount: controller.getSearch().length,
            itemBuilder: (context, index) {
              return FlatButton(
                child: ListTile(
                  title: Text(controller.getSearch()[index].name.toString()),
                  subtitle: Text(
                      controller.getSearch()[index].description.toString()),
                ),
                onPressed: () {
                  setState(() {
                    String name = controller.getSearch()[index].name.toString();
                    if (name.contains('Concorsi'))
                      controller
                          .setLeafInfo(controller.getSearch()[index].url, (
                          el) => Concorso.fromJson(el))
                          .then((value) => visual(index));
                    else if (name.contains('Bandi'))
                      controller
                          .setLeafInfo(controller.getSearch()[index].url, (
                          el) => Bando.fromJson(el))
                          .then((value) => visual(index));
                  });
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
