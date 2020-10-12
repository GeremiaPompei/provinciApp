import 'package:MC/controller/Controller.dart';
import 'package:MC/model/LeafInfo.dart';
import 'package:MC/utility/Style.dart';
import 'package:MC/view/DetailedLeafInfoView.dart';
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
  List<LeafInfo> _leafs;
  String _title;
  Controller _controller;

  _LeafsInfoViewState(this._controller, this._title) {
    this._leafs = this._controller.getLeafs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: AppBar(
        backgroundColor: ThemePrimaryColor,
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
                color: BackgroundColor2,
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
                      child: this._leafs[index].imageFile == null
                          ? Container(
                              height: 55,
                              width: 55,
                              child: Image.asset('assets/logo_mc.PNG'),
                            )
                          : Container(
                              height: 55,
                              width: 55,
                              child: Image.file(this._leafs[index].imageFile),
                            ),
                    ),
                    title: Text(
                      '${_leafs[index].name}',
                      maxLines: 2,
                    ),
                    subtitle: _leafs[index].description == null
                        ? Text('')
                        : Text(
                            '${_leafs[index].description}',
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
                              this._leafs[index].imageFile == null
                                  ? null
                                  : Image.file(
                                      this._leafs[index].imageFile,
                                    ),
                            ),
                          ),
                        );
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
