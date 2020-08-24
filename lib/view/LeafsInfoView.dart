import 'package:MC/controller/Controller.dart';
import 'package:MC/model/LeafInfo.dart';
import 'package:MC/view/DetailedLeafInfoView.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class LeafsInfoView extends StatefulWidget {
  List<LeafInfo> leafs;
  String title;
  Controller controller;

  LeafsInfoView(this.leafs, this.title, this.controller);

  @override
  _LeafsInfoViewState createState() =>
      _LeafsInfoViewState(this.leafs, this.title, this.controller);
}

class _LeafsInfoViewState extends State<LeafsInfoView> {
  List<LeafInfo> leafs;
  String title;
  Controller controller;

  _LeafsInfoViewState(this.leafs, this.title, this.controller);

  @override
  Widget build(BuildContext context) {
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
          return Card(
              child: FlatButton(
                  child: ListTile(
                    title: Text('${leafs[index].getName()}'),
                    subtitle: leafs[index].getDescription() == null
                        ? Text('')
                        : Text('${leafs[index].getDescription()}'),
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailedLeafInfoView(title, leafs[index],controller)));
                    });
                  }));
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
