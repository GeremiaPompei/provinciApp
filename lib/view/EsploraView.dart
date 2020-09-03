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
  Controller controller;
  List<MapEntry<String, UnitCache>> searched;
  List<MapEntry<String, UnitCache>> leafs;
  Widget varWidget;
  String location;

  _EsploraViewState(this.controller) {
    this.searched = this.controller.getLastSearched();
    this.leafs = this.controller.getLastLeafs();
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
                CardsSizedBox(this.searched, this.controller.setSearch,
                    (name) => ScrollListView(this.controller, name)),
                SizedBox(height: 20,),
                CardsSizedBox(
                    this.leafs,
                    this.controller.setLeafInfo,
                    (name) => LeafsInfoView(
                        this.controller.getLeafs(), name, this.controller)),
              ],
            ),
          ),
          loader: LoadingView(),
          onSearch: (input) async => await controller.setSearch(
              input, 'dataset?q=' + input, IconSearch),
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
                      future: controller.setLeafInfo(
                          input.name, input.url, findImage(input.name)),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData)
                          varWidget = LeafsInfoView(this.controller.getLeafs(),
                              input.name, controller);
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
