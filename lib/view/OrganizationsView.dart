import 'package:MC/controller/Controller.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:MC/utility/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

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
  Widget varWidget;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _OrganizationsViewState(this._controller);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        enablePullDown: true,
        header: ClassicHeader(),
        controller: _refreshController,
        onRefresh: () => setState(() {
              this
                  ._controller
                  .getOrganizations()
                  .removeWhere((element) => true);
              this._controller.initOrganizations().then((value) {
                (context as Element).reassemble();
                _refreshController.refreshCompleted();
              });
            }),
        child: GridView.count(
          scrollDirection: Axis.vertical,
          primary: false,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          crossAxisCount: 2,
          children: List.generate(
              this._controller.getOrganizations().length,
              (i) => Card(
                    child: FlatButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 65,
                            child:
                                this._controller.getOrganizations()[i].image !=
                                        null
                                    ? Image(
                                        image: NetworkImage(this
                                            ._controller
                                            .getOrganizations()[i]
                                            .image),
                                      )
                                    : Container(
                                        color: ThemePrimaryColor,
                                        child: Icon(Icons.not_interested),
                                      ),
                          ),
                          Center(
                            child: Text(
                              this._controller.getOrganizations()[i].name,
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
                                            this
                                                ._controller
                                                .getOrganizations()[i]
                                                .name,
                                            this
                                                ._controller
                                                .getOrganizations()[i]
                                                .url,
                                            IconComune),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          Widget tmpWidget;
                                          if (snapshot.hasData)
                                            tmpWidget = ScrollListView(
                                                this._controller,
                                                this
                                                    ._controller
                                                    .getOrganizations()[i]
                                                    .name);
                                          else if (snapshot.hasError) {
                                            tmpWidget = Scaffold(
                                                appBar: AppBar(
                                                  title: Text(
                                                    this
                                                        ._controller
                                                        .getOrganizations()[i]
                                                        .name,
                                                    style: TitleTextStyle,
                                                  ),
                                                  backgroundColor:
                                                      BackgroundColor,
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
        ));
  }
}
