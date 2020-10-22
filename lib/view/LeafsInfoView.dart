import 'package:provinciApp/controller/Controller.dart';
import 'package:provinciApp/model/risorsa.dart';
import 'package:provinciApp/utility/Style.dart';
import 'package:provinciApp/view/DetailedLeafInfoView.dart';
import 'package:flutter/material.dart';

class LeafsInfoView extends StatefulWidget {
  String _title;
  Controller _controller;

  LeafsInfoView(this._controller, this._title);

  @override
  _LeafsInfoViewState createState() =>
      _LeafsInfoViewState(this._controller, this._title);
}

class _LeafsInfoViewState extends State<LeafsInfoView> {
  List<Risorsa> _leafs;
  String _title;
  Controller _controller;

  _LeafsInfoViewState(this._controller, this._title) {
    this._leafs = this._controller.getLeafs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor2,
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        title: Text(
          _title,
          style: ReverseTitleTextStyle,
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
      body: Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: _leafs.length,
          itemBuilder: (context, index) {
            Icon icon;
            this._controller.getOffline().contains(_leafs[index])
                ? icon = Icon(Icons.remove_circle_outline)
                : icon = Icon(Icons.add_circle_outline);
            return Container(
              alignment: Alignment.center,
              height: 85,
              child: Card(
                color: BackgroundColor,
                child: Container(
                  height: 80,
                  alignment: Alignment.center,
                  child: ListTile(
                      trailing: IconButton(
                        icon: icon,
                        onPressed: () {
                          setState(() {
                            if (this
                                ._controller
                                .getOffline()
                                .contains(_leafs[index])) {
                              this._controller.removeOffline(_leafs[index]);
                            } else {
                              this._controller.addOffline(_leafs[index]);
                            }
                          });
                        },
                      ),
                      leading: Container(
                        height: 55,
                        child: this._leafs[index].immagineFile == null
                            ? Container(
                                height: 55,
                                width: 55,
                                child: Image.asset('assets/logo_mc.PNG'),
                              )
                            : Container(
                                height: 55,
                                width: 55,
                                child: Image.file(this._leafs[index].immagineFile),
                              ),
                      ),
                      title: Text(
                        '${_leafs[index].nome}',
                        maxLines: 2,
                      ),
                      subtitle: _leafs[index].descrizione == null
                          ? Text('')
                          : Text(
                              '${_leafs[index].descrizione}',
                              maxLines: 2,
                            ),
                      onTap: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailedLeafInfoView(
                                _title,
                                _leafs[index],
                                _controller,
                                this._leafs[index].immagineFile == null
                                    ? null
                                    : Image.file(
                                        this._leafs[index].immagineFile,
                                      ),
                              ),
                            ),
                          ).then((value) {
                            setState(() {
                              (context as Element).reassemble();
                            });
                          });
                        });
                      }),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
