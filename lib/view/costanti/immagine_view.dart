import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provinciApp/view/stile/colore.dart';
import 'custom_appbar.dart';

/// ImmagineView mostra in una vista un'immagine in un container a forma di
/// cerchio.
class ImmagineView extends StatefulWidget {
  /// Nome dell'immagine mostrata.
  String _nome;

  /// Immagine da mostrare.
  File _immagine;

  ImmagineView(this._immagine, this._nome);

  @override
  _ImmagineViewState createState() => _ImmagineViewState();
}

class _ImmagineViewState extends State<ImmagineView> {
  @override
  Widget build(BuildContext context) {
    ImageProvider _image = Image.file(widget._immagine).image;
    return FlatButton(
      child: Container(
        width: 150.0,
        height: 150.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
            fit: BoxFit.fill,
            image: _image,
          ),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: CustomAppBar(
                titolo: widget._nome,
              ),
              body: Container(
                color: Colore.scuro,
                alignment: Alignment.center,
                child: PhotoView(
                  imageProvider: _image,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
