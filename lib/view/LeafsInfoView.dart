import 'package:MC/controller/Controller.dart';
import 'package:MC/model/LeafInfo.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class LeafsInfoView {
  List<LeafInfo> leafs;
  String title;
  Controller controller;

  LeafsInfoView(this.leafs, this.title, this.controller);

  Scaffold launch(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(title),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
      body: ButtonInfo(leafs, title, controller),
    );
  }
}

class ButtonInfo extends StatefulWidget {
  List<LeafInfo> leafs;
  String title;
  Controller controller;

  ButtonInfo(this.leafs, this.title, this.controller);

  @override
  _ButtonInfoState createState() => _ButtonInfoState(leafs, title, controller);
}

class _ButtonInfoState extends State<ButtonInfo> {
  List<LeafInfo> leafs;
  String title;
  Controller controller;

  _ButtonInfoState(this.leafs, this.title, this.controller);

  int length() {
    if (controller.getLeafs() != null)
      return controller.getLeafs().length;
    else
      return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: length(),
        itemBuilder: (context, index) {
          return FlatButton(
              child: ListTile(
                title: Text(leafs[index].getName()),
                subtitle: Text(leafs[index].getDescription()),
              ),
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => leafInfo(index, context)));
                });
              });
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  Scaffold leafInfo(int index, BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(leafs[index].getName()),
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
                  Share.share(leafs[index].toString(),
                      subject: title,
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
                    leafs[index].toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ))));
  }
}
