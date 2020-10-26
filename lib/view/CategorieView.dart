import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/model/pacchetto.dart';
import 'package:provinciApp/utility/Style.dart';
import 'package:provinciApp/view/EmptyView.dart';
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
  List<Future<Pacchetto>> _nodes;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _CategoriesViewState(this._controller) {
    this._nodes = this._controller.getCategories();
  }

  Widget _getImage(dynamic image) => FutureBuilder<dynamic>(
        future: this._controller.tryConnection(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Widget tmpWidget;
          if (snapshot.hasError || image == null)
            tmpWidget = Image(
              image: AssetImage(
                'assets/empty.png',
              ),
              height: 87,
              width: 87,
            );
          else if (snapshot.hasData)
            tmpWidget = Image(image: NetworkImage(image));
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
          this._controller.getCategories().removeWhere((element) => true);
          this._controller.initCategories().then((value) {
            this._nodes = this._controller.getCategories();
            (context as Element).reassemble();
            _refreshController.refreshCompleted();
          });
        });
      },
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.all(15),
        children: List.generate(
          this._nodes.length,
          (index) {
            return FutureBuilder(
                future: this._nodes[index],
                builder: (context, snapshot) {
                  Widget tmpWidget;
                  if (snapshot.hasData) {
                    Pacchetto node = snapshot.data;
                    tmpWidget = Container(
                      height: 110,
                      margin: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: new Stack(
                        children: <Widget>[
                          new Container(
                            height: 124.0,
                            width: MediaQuery.of(context).size.width,
                            margin: new EdgeInsets.only(left: 46.0),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FutureBuilder<dynamic>(
                                      future: _controller.setSearch(
                                          node.nome, node.url, IconCategory),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        Widget tmpWidget;
                                        if (snapshot.hasData) if (snapshot
                                            .data.isNotEmpty)
                                          tmpWidget = ScrollListView(
                                              this._controller, node.nome);
                                        else
                                          tmpWidget = Scaffold(
                                            body: EmptyView(node.nome),
                                          );
                                        else if (snapshot.hasError)
                                          tmpWidget = OfflineView(node.nome);
                                        else
                                          tmpWidget = LoadingView();
                                        return tmpWidget;
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: Center(
                                child: Text(
                                  node.nome.toString(),
                                  style: TitleTextStyle_20,
                                ),
                              ),
                            ),
                            decoration: new BoxDecoration(
                              color: BackgroundColor,
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
                              child: _getImage(node.immagineUrl)),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    tmpWidget = Container();
                  } else {
                    tmpWidget = Container(
                      height: 110,
                      margin: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: new Container(
                        height: 124.0,
                        width: MediaQuery.of(context).size.width,
                        margin: new EdgeInsets.only(left: 46.0),
                        decoration: new BoxDecoration(
                          color: BackgroundColor,
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
                    );
                  }
                  return tmpWidget;
                });
          },
        ),
      ),
    );
  }
}
