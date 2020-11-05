import 'package:flutter/cupertino.dart';

/// ImmagineView mostra in una vista un'immagine in un container a forma di
/// cerchio.
class ImmagineView extends StatefulWidget {
  /// Immagine da mostrare.
  Image _immagine;

  ImmagineView(this._immagine);

  @override
  _ImmagineViewState createState() => _ImmagineViewState();
}

class _ImmagineViewState extends State<ImmagineView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      height: 150.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        image: new DecorationImage(
          fit: BoxFit.fill,
          image: widget._immagine.image,
        ),
      ),
    );
  }
}
