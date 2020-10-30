import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/model/pacchetto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/utility/stile/colore.dart';
import 'package:provinciApp/utility/stile/icona.dart';
import 'package:provinciApp/utility/stile/stiletesto.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'custom/custom_futurebuilder.dart';
import 'lista_pacchetti_view.dart';

class ComuniView extends StatefulWidget {
  Controller _controller;

  ComuniView(this._controller);

  @override
  _ComuniViewState createState() => _ComuniViewState();
}

class _ComuniViewState extends State<ComuniView> {
  List<Future<Pacchetto>> _nodes;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    this._nodes = widget._controller.comuni;
  }

  Widget _getImage(dynamic image) => image == null
      ? Container(
          height: 55,
          width: 55,
          child: Image.asset('assets/logo_mc.PNG'),
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
            widget._controller.comuni.removeWhere((element) => true);
            widget._controller.initComuni().then((value) {
              this._nodes = widget._controller.comuni;
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
            this._nodes.length,
            (index) => FutureBuilder(
                future: this._nodes[index],
                builder: (context, snapshot) {
                  Widget tmpWidget;
                  if (snapshot.hasData) {
                    Pacchetto node = snapshot.data;
                    tmpWidget = Card(
                      color: Colore.chiaro,
                      child: Stack(children: [
                        FlatButton(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                  height: 65,
                                  child: _getImage(node.immagineUrl)),
                              Center(
                                child: Text(
                                  node.nome,
                                  style: StileTesto.corpo,
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomFutureBuilder(
                                    widget._controller.cercaFromUrl(
                                        node.nome, node.url, Icona.comuni),
                                    node.nome,
                                    ListaPacchettiView(widget._controller),
                                  ),
                                ),
                              );
                            });
                          },
                        ),
                      ]),
                    );
                  } else if (snapshot.hasError) {
                    tmpWidget = Card(
                      color: Colore.chiaro,
                    );
                  } else {
                    tmpWidget = Card(
                      color: Colore.chiaro,
                    );
                  }
                  return tmpWidget;
                }),
          ),
        ));
  }
}
