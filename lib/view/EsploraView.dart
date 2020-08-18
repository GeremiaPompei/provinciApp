import 'package:MC/controller/Controller.dart';
import 'package:MC/view/CardsSizedBox.dart';
import 'package:MC/view/ScrollListView.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EsploraView extends StatefulWidget {
  Controller controller;

  EsploraView(this.controller);

  @override
  _EsploraViewState createState() => _EsploraViewState(this.controller);
}

class _EsploraViewState extends State<EsploraView> {
  Controller controller;

  _EsploraViewState(this.controller);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Flexible(
          child: ListView(shrinkWrap: true, children: <Widget>[
            TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
              ),
              onSubmitted: (String input) {
                setState(() {
                  controller
                      .setSearch('dataset?q=' + input)
                      .then((value) =>
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ScrollListView(
                                        this.controller, input)));
                      }));
                });
              },
            ),
            SizedBox(
              child: Center(
                child: Text(
                  'Comuni',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            CardsSizedBox(this.controller, this.controller.getOrganizations()),
            SizedBox(
              child: Center(
                child: Text(
                  'Categorie',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            CardsSizedBox(this.controller, this.controller.getCategories()),
          ]),
        ),
      ],
    );
  }
}
