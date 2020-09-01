import 'package:MC/controller/Controller.dart';
import 'package:MC/utility/Style.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'LoadingView.dart';
import 'OfflineView.dart';
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
              child: Center(
                child: ListTile(
                  title: AutoSizeText(
                      this
                          ._controller
                          .getOrganizations()[index]
                          .name
                          .toString(),
                      maxFontSize: 15,
                      maxLines: 3,
                      textAlign: TextAlign.center),
                  subtitle: this._controller.getOrganizations()[index].image !=
                          null
                      ? Image(
                          image: NetworkImage(
                              this._controller.getOrganizations()[index].image))
                      : Container(
                          child: Icon(Icons.check_box_outline_blank, size: 50),
                        ),
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
                                            .url),
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
              ),
            );
          },
        ),
      ),
    );
  }
}
