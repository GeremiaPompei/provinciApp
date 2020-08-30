import 'package:MC/controller/Controller.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import 'LoadingView.dart';
import 'ScrollListView.dart';

class GridListView extends StatefulWidget {
  List<NodeInfo> _nodes;
  Future<dynamic> _init;
  Controller _controller;

  GridListView(this._controller, this._nodes, this._init);

  @override
  _GridListViewState createState() =>
      _GridListViewState(this._controller, this._nodes, this._init);
}

class _GridListViewState extends State<GridListView> {
  Controller _controller;
  List<NodeInfo> _nodes;
  Future<dynamic> _init;
  Widget varWidget;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _GridListViewState(this._controller, this._nodes, this._init);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      header: ClassicHeader(),
      controller: _refreshController,
      onRefresh: () => setState(() {
        this._init.then((value) {
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
          this._nodes.length,
          (index) {
            return FlatButton(
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    title: Text(this._nodes[index].name.toString()),
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FutureBuilder<dynamic>(
                                  future: _controller.setSearch(
                                      this._nodes[index].name,
                                      this._nodes[index].url),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.hasData)
                                      varWidget = ScrollListView(
                                          this._controller, _nodes[index].name);
                                    else if (snapshot.hasError)
                                      Navigator.pushReplacementNamed(
                                          context, '/offline');
                                    else
                                      varWidget = LoadingView();
                                    return varWidget;
                                  },
                                )));
                  });
                  if (await canLaunch(this._nodes[index].url)) {
                    await launch(this._nodes[index].url);
                  } else {
                    throw 'Could not launch ${this._nodes[index].url}';
                  }
                });
          },
        ),
      ),
    );
  }
}
