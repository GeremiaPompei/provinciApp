import 'package:MC/controller/Controller.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import 'LoadingView.dart';
import 'ScrollListView.dart';

class CategoriesView extends StatefulWidget {
  Controller _controller;

  CategoriesView(this._controller);

  @override
  _CategoriesViewState createState() =>
      _CategoriesViewState(this._controller);
}

class _CategoriesViewState extends State<CategoriesView> {
  Controller _controller;
  Widget varWidget;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  _CategoriesViewState(this._controller);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      header: ClassicHeader(),
      controller: _refreshController,
      onRefresh: () => setState(() {
        this._controller.initOrganizations().then((value) {
          (context as Element).reassemble();
          _refreshController.refreshCompleted();
        });
      }),
      child: GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        crossAxisCount: 2,
        children: List.generate(
          this._controller.getCategories().length,
              (index) {
            return FlatButton(
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    title: Text(this._controller.getCategories()[index].name.toString()),
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FutureBuilder<dynamic>(
                              future: _controller.setSearch(
                                  this._controller.getCategories()[index].name,
                                  this._controller.getCategories()[index].url),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData)
                                  varWidget = ScrollListView(
                                      this._controller, this._controller.getCategories()[index].name);
                                else if (snapshot.hasError)
                                  Navigator.pushReplacementNamed(
                                      context, '/offline');
                                else
                                  varWidget = LoadingView();
                                return varWidget;
                              },
                            )));
                  });
                });
          },
        ),
      ),
    );
  }
}
