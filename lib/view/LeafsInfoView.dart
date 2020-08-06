import 'package:MC/model/LeafInfo.dart';
import 'package:flutter/material.dart';

class LeafsInfoView {
  List<LeafInfo> leafs;
  String title;

  LeafsInfoView(this.leafs, this.title);

  void launch() {
    runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text(title),
          ),
          body: ButtonInfo(leafs, title),
        ),
      ),
    );
  }
}

class ButtonInfo extends StatefulWidget {
  List<LeafInfo> leafs;
  String title;

  ButtonInfo(this.leafs, this.title);

  @override
  _ButtonInfoState createState() => _ButtonInfoState(leafs, title);
}

class _ButtonInfoState extends State<ButtonInfo> {
  List<LeafInfo> leafs;
  String title;

  _ButtonInfoState(this.leafs, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: leafs.length,
        itemBuilder: (context, index) {
          return FlatButton(
              child: ListTile(
                title: Text(leafs[index].comune.toString()),
                subtitle: Text(leafs[index].oggetto.toString()),
              ),
              onPressed: () {
                setState(() {
                  print(leafs[index].toString());
                });
              });
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
