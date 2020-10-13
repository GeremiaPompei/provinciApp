import 'package:MC/model/UnitCache.dart';
import 'package:MC/utility/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
                color: BackgroundColor2,
                child: FlatButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 65,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'assets/empty.png',
                            ),
                            this._list[i].value.icon == null
                                ? Image.asset('assets/empty.png')
                                : Icon(
                                    IconData((this._list[i].value.icon),
                                        fontFamily: 'MaterialIcons'),
                                    color: BackgroundColor,
                                  ),
                          ],
                        ),
                      ),
                      Center(
                        child: Text(
                          this._list[i].value.name,
                          style: TitleTextStyle_20,
                          maxLines: 3,
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
                                        this._list[i].value.icon),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<dynamic> snapshot) {
                                      Widget tmpWidget;
                                      if (snapshot.hasData)
                                        tmpWidget = this
                                            ._funcWidget(_list[i].value.name);
                                      else if (snapshot.hasError) {
                                        tmpWidget =
                                            OfflineView(_list[i].value.name);
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
