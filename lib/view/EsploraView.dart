import 'package:MC/controller/Controller.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:MC/model/UnitCache.dart';
import 'package:MC/utility/ConstUrl.dart';
import 'package:MC/utility/Style.dart';
import 'package:MC/view/EmptyView.dart';
import 'package:MC/view/LeafsInfoView.dart';
import 'package:MC/view/LoadingView.dart';
import 'package:MC/view/ScrollListView.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'OfflineView.dart';

class EsploraView extends StatefulWidget {
  Controller _controller;

  EsploraView(this._controller);

  @override
  _EsploraViewState createState() => _EsploraViewState(this._controller);
}

class _EsploraViewState extends State<EsploraView> {
  Controller _controller;

  _EsploraViewState(this._controller);

  Widget _cardsSizedBox(
          List<MapEntry<String, UnitCache>> _list,
          Future<dynamic> Function(String name, String url, int image) _func,
          Widget Function(String name) _funcWidget,
          BuildContext context) =>
      GridView.count(
        scrollDirection: Axis.vertical,
        primary: false,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        crossAxisCount: 2,
        children: List.generate(
            _list.length,
            (i) => Card(
                  color: BackgroundColor,
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
                              _list[i].value.icon == null
                                  ? Image.asset('assets/empty.png')
                                  : Icon(
                                      IconData((_list[i].value.icon),
                                          fontFamily: 'MaterialIcons'),
                                      color: BackgroundColor,
                                    ),
                            ],
                          ),
                        ),
                        Center(
                          child: Text(
                            _list[i].value.name,
                            style: TitleTextStyle_20,
                            maxLines: 2,
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
                              future: _func(_list[i].value.name, _list[i].key,
                                  _list[i].value.icon),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                Widget tmpWidget;
                                if (snapshot.hasData)
                                  tmpWidget = _funcWidget(_list[i].value.name);
                                else if (snapshot.hasError) {
                                  tmpWidget = OfflineView(_list[i].value.name);
                                } else
                                  tmpWidget = LoadingView();
                                return tmpWidget;
                              },
                            ),
                          ),
                        ).then((value) {
                          setState(() {
                            (context as Element).reassemble();
                          });
                        });
                      });
                    },
                  ),
                )),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: SearchBar<NodeInfo>(
            searchBarStyle: SearchBarStyle(
              backgroundColor: BackgroundColor,
              padding: EdgeInsets.all(6),
            ),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            icon: Icon(Icons.search),
            minimumChars: 1,
            placeHolder: SingleChildScrollView(
              child: Column(
                children: [
                  _cardsSizedBox(
                      this._controller.getLastSearched(),
                      this._controller.setSearch,
                      (name) => ScrollListView(this._controller, name),
                      context),
                  SizedBox(
                    height: 20,
                  ),
                  _cardsSizedBox(
                      this._controller.getLastLeafs(),
                      this._controller.setLeafInfo,
                      (name) => LeafsInfoView(this._controller, name),
                      context),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            loader: LoadingView(),
            onSearch: (input) async => await _controller.setSearch(
                input, MCDATASET_SEARCH + input, IconSearch),
            onError: (err) => EmptyView(null),
            onItemFound: (input, num) {
              return Container(
                child: ListTile(
                  isThreeLine: true,
                  title: Text(input.name),
                  subtitle: Text(input.description),
                  leading: Stack(alignment: Alignment.center, children: [
                    Image.asset('assets/empty.png'),
                    Icon(IconData(findImage(input.name),
                        fontFamily: 'MaterialIcons'))
                  ]),
                  onTap: () async {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => FutureBuilder<dynamic>(
                          future: _controller.setLeafInfo(
                              input.name, input.url, findImage(input.name)),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            Widget tmpWidget;
                            if (snapshot.hasData)
                              tmpWidget =
                                  LeafsInfoView(_controller, input.name);
                            else if (snapshot.hasError)
                              tmpWidget = OfflineView(input.name);
                            else
                              tmpWidget = LoadingView();
                            return tmpWidget;
                          },
                        ),
                      ),
                    )
                        .then((value) {
                      setState(() {
                        (context as Element).reassemble();
                      });
                    });
                  },
                ),
              );
            }),
      ),
    );
  }
}
