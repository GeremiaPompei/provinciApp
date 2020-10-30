import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/model/pacchetto.dart';
import 'package:provinciApp/utility/stile/colore.dart';
import 'package:provinciApp/utility/stile/icona.dart';
import 'package:provinciApp/utility/stile/stiletesto.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'custom/custom_futurebuilder.dart';
import 'lista_pacchetti_view.dart';

class CategorieView extends StatefulWidget {
  Controller _controller;

  CategorieView(this._controller);

  @override
  _CategorieViewState createState() => _CategorieViewState();
}

class _CategorieViewState extends State<CategorieView> {
  List<Future<Pacchetto>> _nodes;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _CategorieViewState() {
    this._nodes = widget._controller.categorie;
  }

  Widget _getImage(dynamic image) => image == null
      ? Image(
          image: AssetImage(
            'assets/empty.png',
          ),
          height: 87,
          width: 87,
        )
      : Image(image: NetworkImage(image));

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
            this._nodes = widget._controller.categorie;
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
                                    builder: (context) => CustomFutureBuilder(
                                      widget._controller.cercaFromUrl(
                                          node.nome, node.url, Icona.categorie),
                                      node.nome,
                                      ListaPacchettiView(widget._controller),
                                    ),
                                  ),
                                );
                              },
                              child: Center(
                                child: Text(
                                  node.nome.toString(),
                                  style: StileTesto.corpo,
                                ),
                              ),
                            ),
                            decoration: new BoxDecoration(
                              color: Colore.chiaro,
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
                          color: Colore.chiaro,
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
