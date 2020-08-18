import 'package:MC/controller/Controller.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ScrollListView.dart';

class CardsSizedBox extends StatefulWidget {
  Controller controller;
  List<NodeInfo> list;

  CardsSizedBox(this.controller,this.list);

  @override
  _CardsSizedBoxState createState() => _CardsSizedBoxState(this.controller,this.list);
}

class _CardsSizedBoxState extends State<CardsSizedBox> {
  Controller controller;
  List<NodeInfo> list;
  int _index;

  _CardsSizedBoxState(this.controller,this.list);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: this.list.length,
        controller: PageController(viewportFraction: 0.7),
        onPageChanged: (int index) => setState(() => _index = index),
        itemBuilder: (_, i) => Transform.scale(
            scale: _index == i ? 1 : 0.9,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: FlatButton(
                child: Text(this.list[i].name),
                onPressed: () {
                  setState(() {
                    controller
                        .setSearch(this.list[i].url)
                        .then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ScrollListView(this.controller,list[i].name))));
                  });
                },
              ),
            )),
      ),
    );
  }
}
