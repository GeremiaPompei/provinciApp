import 'package:MC/controller/Controller.dart';
import 'package:MC/model/UnitCache.dart';
import 'package:MC/utility/Style.dart';
import 'package:MC/view/SavedView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoadingView.dart';
import 'OfflineView.dart';

class CardsSizedBox extends StatefulWidget {
  List<MapEntry<String, UnitCache>> _list;
  Future<dynamic> Function(String name, String url, int image) _func;
  Widget Function(String name) _funcWidget;

  CardsSizedBox(this._list, this._func, this._funcWidget);

  @override
  _CardsSizedBoxState createState() =>
      _CardsSizedBoxState(this._list, this._func, this._funcWidget);
}

class _CardsSizedBoxState extends State<CardsSizedBox> {
  List<MapEntry<String, UnitCache>> _list;
  Future<dynamic> Function(String name, String url, int image) _func;
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
                leading: Stack(alignment: Alignment.center, children: [
                  Image.asset('assets/empty.png'),
                  this._list[i].value.image == null
                      ? Image.asset('assets/empty.png')
                      : Icon(IconData((this._list[i].value.image),
                          fontFamily: 'MaterialIcons'))
                ]),
                onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FutureBuilder<dynamic>(
                                  future: _func(
                                      this._list[i].value.name,
                                      this._list[i].key,
                                      this._list[i].value.image),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    Widget tmpWidget;
                                    if (snapshot.hasData)
                                      tmpWidget =
                                          this._funcWidget(_list[i].value.name);
                                    else if (snapshot.hasError) {
                                      tmpWidget = Scaffold(
                                          appBar: AppBar(
                                            title: Text(
                                              _list[i].value.name,
                                              style: TitleTextStyle,
                                            ),
                                            backgroundColor: BackgroundColor,
                                          ),
                                          body: OfflineView());
                                    } else
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
