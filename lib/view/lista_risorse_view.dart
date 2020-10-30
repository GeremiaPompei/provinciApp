import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/model/risorsa.dart';
import 'package:provinciApp/utility/stile/colore.dart';
import 'package:provinciApp/utility/stile/icona.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'DetailedLeafInfoView.dart';
import 'custom/custom_icon.dart';

/// ListaRisorseView da la vista personalizzata di una lista di risorse.
class ListaRisorseView extends StatefulWidget {
  Controller _controller;

  /// Funzione di aggiornamento delle risorse.
  Function(dynamic) _update;

  /// Lista delle risorse.
  List<Risorsa> _risorse;

  ListaRisorseView(this._controller, this._risorse, {Function update}) {
    this._update = update;
  }

  @override
  _ListaRisorseViewState createState() => _ListaRisorseViewState();
}

class _ListaRisorseViewState extends State<ListaRisorseView> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colore.sfondo,
      child: SmartRefresher(
        enablePullDown: widget._update == null ? false : true,
        header: ClassicHeader(),
        controller: _refreshController,
        onRefresh: () => widget._update(_refreshController),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: widget._risorse.length,
          itemBuilder: (context, index) {
            CustomIcon icon;
            widget._controller.offline.contains(widget._risorse[index])
                ? icon = CustomIcon(Icona.rimuoviOffline, Colore.primario)
                : icon = CustomIcon(Icona.salvaOffline, Colore.primario);
            return Card(
              color: Colore.chiaro,
              child: Container(
                height: 100,
                alignment: Alignment.center,
                child: ListTile(
                    trailing: IconButton(
                      icon: icon,
                      onPressed: () {
                        setState(() {
                          if (widget._controller.offline
                              .contains(widget._risorse[index])) {
                            widget._controller
                                .removeOffline(widget._risorse[index]);
                          } else {
                            widget._controller
                                .addOffline(widget._risorse[index]);
                          }
                        });
                      },
                    ),
                    leading: Container(
                      height: 55,
                      width: 55,
                      child: widget._risorse[index].immagineFile == null
                          ? Image.asset('assets/logo_mc.PNG')
                          : Image.file(widget._risorse[index].immagineFile),
                    ),
                    title: Text(
                      widget._risorse[index].nome,
                      maxLines: 2,
                    ),
                    subtitle:
                        widget._risorse.toList()[index].descrizione == null
                            ? Text('')
                            : Text(
                                widget._risorse[index].descrizione,
                                maxLines: 2,
                              ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailedLeafInfoView(
                            widget._risorse[index].nome,
                            widget._risorse[index],
                            widget._controller,
                            widget._risorse[index].immagineFile == null
                                ? null
                                : Image.file(
                                    widget._risorse[index].immagineFile,
                                  ),
                          ),
                        ),
                      ).then((value) {
                        setState(() {
                          (context as Element).reassemble();
                        });
                      });
                    }),
              ),
            );
          },
        ),
      ),
    );
  }
}
