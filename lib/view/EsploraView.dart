import 'package:MC/controller/Controller.dart';
import 'package:MC/model/UnitCache.dart';
import 'package:MC/view/CardsSizedBox.dart';
import 'package:MC/view/LeafsInfoView.dart';
import 'package:MC/view/LoadingView.dart';
import 'package:MC/view/ScrollListView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _EsploraViewState(this.controller) {
    this.searched = this.controller.getLastSearched();
    this.leafs = this.controller.getLastLeafs();
  }

  Future findPosition() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    Position position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    List<Placemark> placemark =
        await geolocator.placemarkFromPosition(position);
    this.location = placemark[0].locality;
    return this
        .controller
        .setSearch(this.location, 'dataset?q=' + this.location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        header: ClassicHeader(),
        controller: _refreshController,
        onRefresh: () => setState(() {
          (context as Element).reassemble();
          _refreshController.refreshCompleted();
        }),
        child: ListView(shrinkWrap: true, children: <Widget>[
          TextField(
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.search),
            ),
            onSubmitted: (String input) {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FutureBuilder<dynamic>(
                              future: controller.setSearch(
                                  input, 'dataset?q=' + input),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData)
                                  varWidget =
                                      ScrollListView(this.controller, input);
                                else if(snapshot.hasError)
                                  Navigator.pushReplacementNamed(context, '/offline');
                                else
                                  varWidget = LoadingView();
                                return varWidget;
                              },
                            )));
              });
            },
          ),
          FlatButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.location_on),
                Text('Posizione Attuale')
              ],
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FutureBuilder<dynamic>(
                            future: findPosition(),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData)
                                varWidget = ScrollListView(
                                    this.controller, this.location);
                              else
                                varWidget = LoadingView();
                              return varWidget;
                            },
                          )));
            },
          ),
          CardsSizedBox(this.searched, this.controller.setSearch,
              (name) => ScrollListView(this.controller, name)),
          CardsSizedBox(
              this.leafs,
              this.controller.setLeafInfo,
              (name) => LeafsInfoView(
                  this.controller.getLeafs(), name, this.controller)),
        ]),
      ),
    );
  }
}
