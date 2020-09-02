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
        this._controller.getOrganizations().removeWhere((element) => true);
        this._controller.initOrganizations().then((value) {
          (context as Element).reassemble();
          _refreshController.refreshCompleted();
        });
      }),
      child: GridView.count(
        primary: false,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        crossAxisCount: 2,
        children: List.generate(
          this._controller.getOrganizations().length,
          (index) {
            return Card(
              child: ListTile(
                title: Text(
                    this._controller.getOrganizations()[index].name.toString() +
                        ' (' +
                        this
                            ._controller
                            .getOrganizations()[index]
                            .description
                            .replaceAll(' Dataset', '') +
                        ')'),
                subtitle: this._controller.getOrganizations()[index].image != null
                    ? Image(
                    image: NetworkImage(
                        this._controller.getOrganizations()[index].image))
                    : null,
                onTap: () async {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FutureBuilder<dynamic>(
                                  future: _controller.setSearch(
                                      this
                                          ._controller
                                          .getOrganizations()[index]
                                          .name,
                                      this
                                          ._controller
                                          .getOrganizations()[index]
                                          .url,IconComune),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.hasData)
                                      varWidget = ScrollListView(
                                          this._controller,
                                          this
                                              ._controller
                                              .getOrganizations()[index]
                                              .name);
                                    else if (snapshot.hasError)
                                      varWidget = Scaffold(
                                          appBar: AppBar(
                                            title: Text(
                                              this
                                                  ._controller
                                                  .getOrganizations()[index]
                                                  .name,
                                              style: TitleTextStyle,
                                            ),
                                            backgroundColor: BackgroundColor,
                                          ),
                                          body: OfflineView());
                                    else
                                      varWidget = LoadingView();
                                    return varWidget;
                                  },
                                )));
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
