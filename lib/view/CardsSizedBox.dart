import 'package:MC/controller/Controller.dart';
import 'package:MC/model/UnitCache.dart';
import 'package:MC/utility/Style.dart';
import 'package:MC/view/SavedView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_map/flutter_map.dart';

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
    return GridView.count(
      scrollDirection: Axis.vertical,
      primary: false,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      crossAxisCount: 2,
      children: List.generate(
          this._list.length,
          (i) => Card(
                child: FlatButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/empty.png',
                            scale: 12,
                          ),
                          this._list[i].value.image == null
                              ? Image.asset('assets/empty.png')
                              : Icon(IconData((this._list[i].value.image),
                                  fontFamily: 'MaterialIcons')),
                        ],
                      ),
                      Center(
                        child: Text(
                          this._list[i].value.name,
                          style: TitleTextStyle_20,
                          maxLines: 30,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
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
                                        tmpWidget = this
                                            ._funcWidget(_list[i].value.name);
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
    );
  }
}
