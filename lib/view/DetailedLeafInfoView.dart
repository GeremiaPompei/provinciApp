import 'package:MC/model/LeafInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class DetailedLeafInfoView extends StatefulWidget {
  LeafInfo leafInfo;
  String title;

  DetailedLeafInfoView(this.title,this.leafInfo);

  @override
  _DetailedLeafInfoViewState createState() => _DetailedLeafInfoViewState(this.title,this.leafInfo);
}

class _DetailedLeafInfoViewState extends State<DetailedLeafInfoView> {
  LeafInfo leafInfo;
  String title;

  _DetailedLeafInfoViewState(this.title,this.leafInfo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.leafInfo.getName()),
          backgroundColor: Colors.red,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                setState(() {
                  final RenderBox box = context.findRenderObject();
                  Share.share(this.leafInfo.toString(),
                      subject: this.title,
                      sharePositionOrigin:
                      box.localToGlobal(Offset.zero) & box.size);
                });
              },
            )
          ],
        ),
        body: Container(
            color: Colors.red,
            constraints: BoxConstraints.expand(),
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    this.leafInfo.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ))));
  }
}
