import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/model/pacchetto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/view/comune_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// Vista rappresentante la vista della lista dei comuni.
class ListaComuniView extends StatefulWidget {
  Controller _controller;

  ListaComuniView(this._controller);

  @override
  _ListaComuniViewState createState() => _ListaComuniViewState();
}

class _ListaComuniViewState extends State<ListaComuniView> {
  /// Lista dei comuni.
  List<Future<Pacchetto>> comuni;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    this.comuni = widget._controller.comuni;
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        enablePullDown: true,
        header: ClassicHeader(),
        controller: _refreshController,
        onRefresh: () {
          setState(() {
            widget._controller.comuni.removeWhere((element) => true);
            widget._controller.initComuni().then((value) {
              this.comuni = widget._controller.comuni;
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
            this.comuni.length,
            (index) => FutureBuilder(
              future: this.comuni[index],
              builder: (context, snapshot) =>
                  ComuneView(widget._controller, snapshot.data),
            ),
          ),
        ));
  }
}
