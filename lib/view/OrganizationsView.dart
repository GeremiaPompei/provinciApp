import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/model/pacchetto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/utility/stile/colore.dart';
import 'package:provinciApp/utility/stile/icona.dart';
import 'package:provinciApp/utility/stile/stiletesto.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'EmptyView.dart';
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
  List<Future<Pacchetto>> _nodes;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _OrganizationsViewState(this._controller) {
    this._nodes = this._controller.comuni;
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
            this._controller.comuni.removeWhere((element) => true);
            this._controller.initComuni().then((value) {
              this._nodes = this._controller.comuni;
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
                                  style: StileTesto.sottotitolo,
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
                                      builder: (context) =>
                                          FutureBuilder<dynamic>(
                                            future: this
                                                ._controller
                                                .cercaFromUrl(node.nome,
                                                    node.url, Icona.comuni),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<dynamic>
                                                    snapshot) {
                                              Widget tmpWidget;
                                              if (snapshot.hasData) if (snapshot
                                                  .data.isNotEmpty)
                                                tmpWidget = ScrollListView(
                                                    this._controller,
                                                    node.nome);
                                              else
                                                tmpWidget = Scaffold(
                                                  body: EmptyView(node.nome),
                                                );
                                              else if (snapshot.hasError) {
                                                tmpWidget =
                                                    OfflineView(node.nome);
                                              } else
                                                tmpWidget = LoadingView();
                                              return tmpWidget;
                                            },
                                          )));
                            });
                          },
                        ),
                      ]),
                    );
                  } else if (snapshot.hasError) {
                    tmpWidget = Container();
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
