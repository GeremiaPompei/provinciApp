import 'package:MC/controller/Controller.dart';
import 'package:MC/utility/Style.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'LoadingView.dart';
import 'OfflineView.dart';
import 'SavedView.dart';
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
            return Container(
              height: 100,
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: FlatButton(
                child: new Stack(
                  children: <Widget>[
                    new Container(
                      height: 124.0,
                      width: MediaQuery.of(context).size.width,
                      margin: new EdgeInsets.only(left: 46.0),
                      child: Center(
                          child: Text(
                        this._controller.getCategories()[index].name.toString(),
                        style: TitleTextStyle_20,
                      )),
                      decoration: new BoxDecoration(
                        color: BackgroundColor2,
                        shape: BoxShape.rectangle,
                        borderRadius: new BorderRadius.circular(8.0),
                        boxShadow: <BoxShadow>[
                          new BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            offset: new Offset(0.0, 10.0),
                          ),
                        ],
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.symmetric(vertical: 10.0),
                      alignment: FractionalOffset.centerLeft,
                      child:
                          this._controller.getCategories()[index].image != null
                              ? Image(
                                  image: NetworkImage(this
                                      ._controller
                                      .getCategories()[index]
                                      .image),
                                )
                              : Image(
                                  image: AssetImage(
                                    'assets/empty.png',
                                  ),
                                  height: 100,
                                  width: 100,
                                ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FutureBuilder<dynamic>(
                                future: _controller.setSearch(
                                    this
                                        ._controller
                                        .getCategories()[index]
                                        .name,
                                    this._controller.getCategories()[index].url,
                                    IconCategory),
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
                                    varWidget = OfflineView(this
                                        ._controller
                                        .getCategories()[index]
                                        .name);
                                  else
                                    varWidget = LoadingView();
                                  return varWidget;
                                },
                              )));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
