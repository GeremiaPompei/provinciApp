import 'package:MC/controller/Controller.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:MC/model/UnitCache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoadingView.dart';
import 'ScrollListView.dart';

class CardsSizedBox extends StatefulWidget {
  List<MapEntry<String, UnitCache>> _list;
  Future<dynamic> Function(String name,String url) _func;
  Widget Function(String name) _funcWidget;

  CardsSizedBox(this._list, this._func,this._funcWidget);

  @override
  _CardsSizedBoxState createState() =>
      _CardsSizedBoxState(this._list,this._func,this._funcWidget);
}

class _CardsSizedBoxState extends State<CardsSizedBox> {
  List<MapEntry<String, UnitCache>> _list;
  int _index;
  Future<dynamic> Function(String name,String url) _func;
  Widget Function(String name) _funcWidget;

  _CardsSizedBoxState(this._list,this._func,this._funcWidget);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: PageView.builder(
        itemCount: this._list.length,
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
                child: ListTile(
                  title: Text(this._list[i].value.name),
                ),
                onPressed: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FutureBuilder<dynamic>(
                                  future: _func(
                                      this._list[i].value.name,
                                      this._list[i].key),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    Widget tmpWidget;
                                    if (snapshot.hasData)
                                      tmpWidget = this._funcWidget(_list[i].value.name);
                                    else
                                      tmpWidget = LoadingView();
                                    return tmpWidget;
                                  },
                                )));
                  });
                },
              ),
            )),
      ),
    );
  }
}
