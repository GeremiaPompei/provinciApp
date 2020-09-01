import 'package:MC/controller/Controller.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:MC/model/UnitCache.dart';
import 'package:MC/utility/Style.dart';
import 'package:MC/view/CardsSizedBox.dart';
import 'package:MC/view/LeafsInfoView.dart';
import 'package:MC/view/LoadingView.dart';
import 'package:MC/view/ScrollListView.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'OfflineView.dart';

class EsploraView extends StatefulWidget {
  Controller controller;

  EsploraView(this.controller);

  @override
  _EsploraViewState createState() => _EsploraViewState(this.controller);
}

class _EsploraViewState extends State<EsploraView> {
  Controller _controller;
  List<MapEntry<String, UnitCache>> searched;
  List<MapEntry<String, UnitCache>> leafs;
  String location;

  _EsploraViewState(this._controller) {
    this.searched = this._controller.getLastSearched();
    this.leafs = this._controller.getLastLeafs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchBar<NodeInfo>(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          icon: Icon(Icons.search),
          placeHolder: SingleChildScrollView(
            child: Column(
              children: [
                CardsSizedBox(
                    this.searched,
                    this._controller.setSearch,
                    (name) => ScrollListView(this._controller, name),
                    this._controller),
                CardsSizedBox(
                    this.leafs,
                    this._controller.setLeafInfo,
                    (name) => LeafsInfoView(
                        this._controller.getLeafs(), name, this._controller),
                    this._controller),
              ],
            ),
          ),
          onSearch: (input) async =>
              await _controller.setSearch(input, 'dataset?q=' + input),
          onItemFound: (input, num) {
            return Container(
              child: ListTile(
                title: Text(input.name),
                isThreeLine: true,
                subtitle: Text(input.description),
                onTap: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FutureBuilder<dynamic>(
                      future: _controller.setLeafInfo(input.name, input.url),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        Widget varWidget;
                        if (snapshot.hasData)
                          varWidget = LeafsInfoView(this._controller.getLeafs(),
                              input.name, _controller);
                        else if (snapshot.hasError)
                          varWidget = OfflineView();
                        else
                          varWidget = LoadingView();
                        return varWidget;
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
