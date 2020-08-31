import 'package:MC/controller/Controller.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:MC/model/UnitCache.dart';
import 'package:MC/utility/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoadingView.dart';
import 'OfflineView.dart';
import 'ScrollListView.dart';

class CardsSizedBox extends StatefulWidget {
  List<MapEntry<String, UnitCache>> _list;
  Future<dynamic> Function(String name, String url) _func;
  Widget Function(String name) _funcWidget;

  CardsSizedBox(this._list, this._func, this._funcWidget);

  @override
  _CardsSizedBoxState createState() =>
      _CardsSizedBoxState(this._list, this._func, this._funcWidget);
}

class _CardsSizedBoxState extends State<CardsSizedBox> {
  List<MapEntry<String, UnitCache>> _list;
  Future<dynamic> Function(String name, String url) _func;
  Widget Function(String name) _funcWidget;

  _CardsSizedBoxState(this._list, this._func, this._funcWidget);

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
                                      tmpWidget = Scaffold(
                                          appBar: AppBar(
                                            backgroundColor: BackgroundColor,
                                          ),
                                          body: OfflineView());
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
