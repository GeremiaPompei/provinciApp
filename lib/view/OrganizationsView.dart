import 'package:MC/controller/Controller.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:MC/utility/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import 'EmptyView.dart';
import 'LeafsInfoView.dart';
import 'LoadingView.dart';
import 'OfflineView.dart';
import 'SavedView.dart';
import 'ScrollListView.dart';

class OrganizationsView extends StatefulWidget {
  Controller _controller;

  OrganizationsView(this._controller);

  @override
  _OrganizationsViewState createState() =>
      _OrganizationsViewState(this._controller);
}

class _OrganizationsViewState extends State<OrganizationsView> {
  Controller _controller;
  List<NodeInfo> _nodes;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _OrganizationsViewState(this._controller) {
    this._nodes = this._controller.getOrganizations();
  }

  Widget _getImage(int index) => FutureBuilder<dynamic>(
        future: this._controller.tryConnection(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Widget tmpWidget;
          if (snapshot.hasError || this._nodes[index].image == null)
            tmpWidget = Container(
              height: 55,
              width: 55,
              child: Image.asset('assets/logo_mc.PNG'),
            );
          else if (snapshot.hasData)
            tmpWidget = Image(image: NetworkImage(this._nodes[index].image));
          else
            tmpWidget = CircularProgressIndicator();
          return tmpWidget;
        },
      );

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        enablePullDown: true,
        header: ClassicHeader(),
        controller: _refreshController,
        onRefresh: () {
          setState(() {
            this._controller.getOrganizations().removeWhere((element) => true);
          this._controller.initOrganizations().then((value) {
              this._nodes = this._controller.getOrganizations();
              (context as Element).reassemble();
              _refreshController.refreshCompleted();
            });
          });
        },
        child: GridView.count(
          scrollDirection: Axis.vertical,
          primary: false,
          shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          crossAxisCount: 2,
          children: List.generate(
              this._nodes.length,
              (index) => Card(
                    color: BackgroundColor,
                    child: FlatButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(height: 65, child: _getImage(index)),
                          Center(
                            child: Text(
                              this._nodes[index].name,
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
                                        future: this._controller.setSearch(
                                            this._nodes[index].name,
                                            this._nodes[index].url,
                                            IconComune),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          Widget tmpWidget;
                                          if (snapshot.hasData) if (snapshot
                                              .data.isNotEmpty)
                                            tmpWidget = ScrollListView(
                                                this._controller,
                                                this._nodes[index].name);
                                          else
                                            tmpWidget = Scaffold(
                                              body: EmptyView(
                                                  this._nodes[index].name),
                                            );
                                          else if (snapshot.hasError) {
                                            tmpWidget = OfflineView(
                                                this._nodes[index].name);
                                          } else
                                            tmpWidget = LoadingView();
                                          return tmpWidget;
                                        },
                                      )));
                        });
                      },
                    ),
                  )),
        ));
  }
}
