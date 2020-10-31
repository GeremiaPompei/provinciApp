import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/model/pacchetto.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/view/categoria_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// ListaCategorieView rappresenta la vista della lista delle categorie.
class ListaCategorieView extends StatefulWidget {
  Controller _controller;

  ListaCategorieView(this._controller);

  @override
  _ListaCategorieViewState createState() => _ListaCategorieViewState();
}

class _ListaCategorieViewState extends State<ListaCategorieView> {
  /// Lista delle categorie.
  List<Future<Pacchetto>> _categorie;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    this._categorie = widget._controller.categorie;
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      header: ClassicHeader(),
      controller: _refreshController,
      onRefresh: () {
        setState(() {
          widget._controller.categorie.removeWhere((element) => true);
          widget._controller.initCategorie().then((value) {
            this._categorie = widget._controller.categorie;
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
          this._categorie.length,
          (index) {
            return Container(
              height: 110,
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: FutureBuilder(
                future: this._categorie[index],
                builder: (context, snapshot) =>
                    CategoriaView(widget._controller, snapshot.data),
              ),
            );
          },
        ),
      ),
    );
  }
}
