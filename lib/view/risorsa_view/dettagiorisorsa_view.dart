import 'package:provinciApp/controller/controller.dart';
import 'package:provinciApp/model/risorsa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provinciApp/view/costanti/listatelefoni_view.dart';
import 'package:provinciApp/view/costanti/listinfo_view.dart';
import 'package:provinciApp/view/costanti/mappa_view.dart';
import 'package:provinciApp/view/stile/colore.dart';
import 'package:provinciApp/view/stile/stiletesto.dart';
import 'package:provinciApp/view/costanti/iconbutton_posizione_view.dart';
import 'package:provinciApp/view/costanti/container_borderradius_view.dart';
import 'package:provinciApp/view/costanti/iconbutton_email_view.dart';
import 'package:provinciApp/view/costanti/iconbutton_share_view.dart';
import 'package:provinciApp/view/costanti/iconbutton_url_view.dart';
import 'package:provinciApp/view/costanti/immagine_view.dart';
import 'package:provinciApp/view/risorsa_view/appbar_dettagliorisorsa_view.dart';

/// DettaglioRisorsaView offre la vista di una risorsa nel dettaglio delle sue
/// informazioni.
class DettaglioRisorsaView extends StatefulWidget {
  Controller _controller;

  /// Risorsa da mostrare.
  Risorsa _risorsa;

  DettaglioRisorsaView(this._risorsa, this._controller);

  @override
  _DettaglioRisorsaViewState createState() => _DettaglioRisorsaViewState();
}

class _DettaglioRisorsaViewState extends State<DettaglioRisorsaView> {
  /// Metodo utile per stabilire un padding per tutti gli elementi della vista.
  Widget _addPadding(Widget _widget) => Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: _widget,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colore.primario,
      padding:
          EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top, 20, 0),
      child: Scaffold(
        backgroundColor: Colore.primario,
        body: CustomScrollView(
          slivers: <Widget>[
            AppBarDettaglioRisorsaView(widget._risorsa, widget._controller),
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                if (widget._risorsa.immagineFile != null)
                  _addPadding(ImmagineView(
                    Image.file(
                      widget._risorsa.immagineFile,
                    ),
                  )),
                _addPadding(Text(
                  widget._risorsa.nome,
                  style: StileTesto.titoloChiaro,
                  textAlign: TextAlign.center,
                )),
                if (widget._risorsa.descrizione != null)
                  _addPadding(ContainerBorderRadiusView(
                    Text(
                      widget._risorsa.descrizione,
                      textAlign: TextAlign.center,
                    ),
                  )),
                if (widget._risorsa.info.isNotEmpty)
                  _addPadding(ContainerBorderRadiusView(
                    ListInfoView(widget._risorsa.info),
                    titolo: 'Info',
                  )),
                if (widget._risorsa.telefoni != null)
                  _addPadding(ContainerBorderRadiusView(
                    ListaTelefoniView(widget._risorsa.telefoni),
                    titolo: 'Telefono',
                  )),
                if (widget._risorsa.posizione != null)
                  _addPadding(MappaView(widget._risorsa.posizione)),
                _addPadding(
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (widget._risorsa.email != null)
                          IconButtonEmailView(widget._risorsa.email),
                        if (widget._risorsa.posizione != null)
                          IconButtonPosizioneView(
                              widget._risorsa.posizione, widget._risorsa.nome),
                        if (widget._risorsa.url != null)
                          IconButtonUrlView(widget._risorsa.url),
                        if (widget._risorsa.url != null)
                          IconButtonShareView(widget._risorsa.url),
                      ]),
                ),
                SizedBox(
                  height: 20,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
