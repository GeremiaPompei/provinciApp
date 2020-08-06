import 'package:MC/controller/Controller.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:MC/model/HttpRequest.dart';
import 'package:flutter/material.dart';

class searchView extends StatefulWidget {
  Controller controller;

  searchView(this.controller);

  @override
  _searchViewState createState() => _searchViewState(controller);
}

class _searchViewState extends State<searchView> {
  String text = '';
  Controller controller;

  _searchViewState(this.controller);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        TextField(
          onSubmitted: (String input) {
            setState(() {
              text = input;
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            setState(() {
              controller.setSearch(text);
            });
          },
        ),
        Flexible(
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: controller
                .getSearch()
                .length,
            itemBuilder: (context, index) {
              return FlatButton(
                child: ListTile(
                  title: Text(controller.getSearch()[index].name.toString()),
                  subtitle: Text(
                      controller.getSearch()[index].description.toString()),
                ),
                onPressed: () {
                  setState(() {
                    //TODO Cambiare in altro widget
                    controller
                        .getLeafs(controller.getSearch()[index].url)
                        .asStream()
                        .forEach((element) {
                      print(element);
                    });
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
