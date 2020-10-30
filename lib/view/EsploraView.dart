import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/model/pacchetto.dart';
import 'package:provinciApp/model/cache/unit_cache.dart';
import 'package:provinciApp/utility/costanti/costanti_unitcache.dart';
import 'package:provinciApp/utility/stile/colore.dart';
import 'package:provinciApp/utility/stile/icona.dart';
import 'package:provinciApp/utility/stile/stiletesto.dart';
import 'package:provinciApp/view/vuoto_view.dart';
import 'package:provinciApp/view/loading_view.dart';
import 'package:provinciApp/view/lista_pacchetti_view.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom/custom_futurebuilder.dart';
import 'lista_risorse_view.dart';

class EsploraView extends StatefulWidget {
  Controller _controller;

  EsploraView(this._controller);

  @override
  _EsploraViewState createState() => _EsploraViewState(this._controller);
}

class _EsploraViewState extends State<EsploraView> {
  Controller _controller;

  _EsploraViewState(this._controller);

  Widget _cardsSizedBox(
          List<MapEntry<String, UnitCache>> _list,
          Future<dynamic> Function(String name, String url, int image) _func,
          Widget Function(String name) _funcWidget,
          BuildContext context) =>
      _list.isEmpty
          ? Container()
          : GridView.count(
              scrollDirection: Axis.vertical,
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              crossAxisCount: 2,
              children: List.generate(
                  _list.length,
                  (i) => Card(
                        color: Colore.chiaro,
                        child: FlatButton(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                height: 65,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/empty.png',
                                    ),
                                    _list[i].value.icona == null
                                        ? Image.asset('assets/empty.png')
                                        : Icon(
                                            IconData((_list[i].value.icona),
                                                fontFamily: 'MaterialIcons'),
                                            color: Colore.chiaro,
                                          ),
                                  ],
                                ),
                              ),
                              Center(
                                child: Text(
                                  _list[i].value.nome,
                                  style: StileTesto.corpo,
                                  maxLines: 2,
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
                                      _func(_list[i].value.nome, _list[i].key,
                                          _list[i].value.icona),
                                      _list[i].value.nome,
                                      _funcWidget(_list[i].value.nome)),
                                ),
                              ).then((value) {
                                setState(() {
                                  (context as Element).reassemble();
                                });
                              });
                            });
                          },
                        ),
                      )),
            );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: SearchBar<Pacchetto>(
            searchBarStyle: SearchBarStyle(
              backgroundColor: Colore.chiaro,
              padding: EdgeInsets.all(6),
            ),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            icon: Icon(Icons.search),
            minimumChars: 1,
            placeHolder: SingleChildScrollView(
                child: Column(
              children: [
                _cardsSizedBox(
                    this
                        ._controller
                        .pacchetti
                        .where((element) =>
                            !element.key.contains(CostantiUnitCache.idVuoto))
                        .toList(),
                    this._controller.cercaFromUrl,
                    (name) => ListaPacchettiView(this._controller),
                    context),
                SizedBox(
                  height: 20,
                ),
                _cardsSizedBox(
                    this
                        ._controller
                        .risorse
                        .where((element) =>
                            !element.key.contains(CostantiUnitCache.idVuoto))
                        .toList(),
                    this._controller.cercaRisorse,
                    (name) => ListaRisorseView(
                        widget._controller, widget._controller.ultimeRisorse),
                    context),
                SizedBox(
                  height: 10,
                ),
              ],
            )),
            loader: LoadingView(),
            onSearch: (input) async =>
                await _controller.cercaFromParola(input, Icona.cerca),
            onError: (err) => VuotoView(),
            onItemFound: (input, num) {
              return Container(
                child: ListTile(
                  isThreeLine: true,
                  title: Text(input.nome),
                  subtitle: Text(input.descrizione),
                  leading: Stack(alignment: Alignment.center, children: [
                    Image.asset('assets/empty.png'),
                    Icon(
                      IconData(Icona.trovaIcona(input.nome),
                          fontFamily: 'MaterialIcons'),
                      color: Colore.chiaro,
                    ),
                  ]),
                  onTap: () async {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => CustomFutureBuilder(
                          _controller.cercaRisorse(input.nome, input.url,
                              Icona.trovaIcona(input.nome)),
                          input.nome,
                          ListaRisorseView(widget._controller,
                              widget._controller.ultimeRisorse),
                        ),
                      ),
                    )
                        .then((value) {
                      setState(() {
                        (context as Element).reassemble();
                      });
                    });
                  },
                ),
              );
            }),
      ),
    );
  }
}
