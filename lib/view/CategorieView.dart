import 'package:MC/controller/Controller.dart';
import 'package:MC/utility/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'LoadingView.dart';
import 'OfflineView.dart';
import 'ScrollListView.dart';

class CategoriesView extends StatefulWidget {
  Controller _controller;

  CategoriesView(this._controller);

  @override
  _CategoriesViewState createState() => _CategoriesViewState(this._controller);
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
        this._controller.getCategories().removeWhere((element) => true);
        this._controller.initCategories().then((value) {
          (context as Element).reassemble();
          _refreshController.refreshCompleted();
        });
      }),
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(2),
        children: List.generate(
          this._controller.getCategories().length,
          (index) {
            return Card(
              child: ListTile(
                title: Text(
                    this._controller.getCategories()[index].name.toString()),
                leading: this._controller.getCategories()[index].image != null
                    ? Image(
                        image: NetworkImage(
                            this._controller.getCategories()[index].image),
                      )
                    : Image(image: AssetImage('assets/empty.png')),
                onTap: () async {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FutureBuilder<dynamic>(
                                  future: _controller.setSearch(
                                      this
                                          ._controller
                                          .getCategories()[index]
                                          .name,
                                      this
                                          ._controller
                                          .getCategories()[index]
                                          .url),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.hasData)
                                      varWidget = ScrollListView(
                                          this._controller,
                                          this
                                              ._controller
                                              .getCategories()[index]
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
            );
          },
        ),
      ),
    );
  }
}
