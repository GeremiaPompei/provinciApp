import 'package:MC/controller/Controller.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:MC/model/UnitCache.dart';
import 'package:MC/utility/Style.dart';
import 'package:MC/view/CardsSizedBox.dart';
import 'package:MC/view/EmptyView.dart';
import 'package:MC/view/LeafsInfoView.dart';
import 'package:MC/view/LoadingView.dart';
import 'package:MC/view/ScrollListView.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
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
  List<MapEntry<String, UnitCache>> _searched;
  List<MapEntry<String, UnitCache>> _leafs;

  _EsploraViewState(this._controller) {
    this._searched = this._controller.getLastSearched();
    this._leafs = this._controller.getLastLeafs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SearchBar<NodeInfo>(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          icon: Icon(Icons.search),
          minimumChars: 1,
          placeHolder: SingleChildScrollView(
            child: Column(
              children: [
                CardsSizedBox(this._searched, this._controller.setSearch,
                    (name) => ScrollListView(this._controller, name)),
                SizedBox(
                  height: 20,
                ),
                CardsSizedBox(this._leafs, this._controller.setLeafInfo,
                    (name) => LeafsInfoView(this._controller, name)),
              ],
            ),
          ),
          loader: LoadingView(),
          onSearch: (input) async => await _controller.setSearch(
              input,
              'http://dati.provincia.mc.it/api/3/action/package_search?rows=1000&q=' +
                  input,
              IconSearch),
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FutureBuilder<dynamic>(
                      future: _controller.setLeafInfo(
                          input.name, input.url, findImage(input.name)),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        Widget tmpWidget;
                        if (snapshot.hasData)
                          tmpWidget = LeafsInfoView(_controller, input.name);
                        else if (snapshot.hasError)
                          tmpWidget = OfflineView(input.name);
                        else
                          tmpWidget = LoadingView();
                        return tmpWidget;
                      },
                    ),
                  ));
                },
              ),
            );
          }),
    );
  }
}
