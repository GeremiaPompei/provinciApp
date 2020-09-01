import 'package:MC/model/UnitCache.dart';
import 'package:MC/utility/Style.dart';
import 'package:MC/view/SavedView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoadingView.dart';
import 'OfflineView.dart';

class CardsSizedBox extends StatefulWidget {
  List<MapEntry<String, UnitCache>> _list;
  Future<dynamic> Function(String name, String url) _func;
  Widget Function(String name) _funcWidget;
  Controller _controller;

  CardsSizedBox(this._list, this._func, this._funcWidget,this._controller);

  @override
  _CardsSizedBoxState createState() =>
      _CardsSizedBoxState(this._list, this._func, this._funcWidget,this._controller);
}

class _CardsSizedBoxState extends State<CardsSizedBox> {
  List<MapEntry<String, UnitCache>> _list;
  Future<dynamic> Function(String name, String url) _func;
  Widget Function(String name) _funcWidget;
  Controller _controller;

  _CardsSizedBoxState(this._list, this._func, this._funcWidget,this._controller);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: this._list.length,
        itemBuilder: (_, i) => Transform.scale(
            scale: 1,
            child: Card(
              child: ListTile(
                title: Text(this._list[i].value.name),
                subtitle: Text(this._list[i].value.date.toString()),
                onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FutureBuilder<dynamic>(
                                  future: _func(this._list[i].value.name,
                                      this._list[i].key),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    Widget tmpWidget;
                                    if (snapshot.hasData)
                                      tmpWidget =
                                          this._funcWidget(_list[i].value.name);
                                    else if (snapshot.hasError)
                                      tmpWidget = SavedWidget(this._controller);
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
