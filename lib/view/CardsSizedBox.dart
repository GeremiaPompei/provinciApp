import 'package:MC/controller/Controller.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoadingView.dart';
import 'ScrollListView.dart';

class CardsSizedBox extends StatefulWidget {
  Controller controller;
  List<NodeInfo> list;

  CardsSizedBox(this.controller, this.list);

  @override
  _CardsSizedBoxState createState() =>
      _CardsSizedBoxState(this.controller, this.list);
}

class _CardsSizedBoxState extends State<CardsSizedBox> {
  Controller controller;
  List<NodeInfo> list;
  int _index;
  Widget varWidget;

  _CardsSizedBoxState(this.controller, this.list);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: PageView.builder(
        itemCount: this.list.length,
        controller: PageController(viewportFraction: 0.5),
        onPageChanged: (int index) => setState(() => _index = index),
        itemBuilder: (_, i) => Transform.scale(
          scale: _index == i ? 1 : 0.9,
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: FlatButton(
              onPressed: () {
                setState(
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FutureBuilder<dynamic>(
                          future: controller.setSearch(
                              this.list[i].name, this.list[i].url),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData)
                              varWidget =
                                  ScrollListView(this.controller, list[i].name);
                            else
                              varWidget = LoadingView();
                            return varWidget;
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(this.list[i].name),
                  Image(
                    image: NetworkImage(this.list[i].image),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
