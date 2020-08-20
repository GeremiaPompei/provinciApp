import 'package:MC/controller/Controller.dart';
import 'package:MC/view/LeafsInfoView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MC/model/LeafInfo.dart';

class ScrollListView extends StatefulWidget {
  Controller controller;
  String title;

  ScrollListView(this.controller, this.title);

  @override
  _ScrollListViewState createState() =>
      _ScrollListViewState(this.controller, this.title);
}

class _ScrollListViewState extends State<ScrollListView> {
  Controller controller;
  String title;

  _ScrollListViewState(this.controller, this.title);

  void visual(int index,
      LeafInfo Function(Map<String, dynamic> parsedJson) func) {
    controller
        .setLeafInfo(controller.getSearch()[index].url, (el) => func(el))
        .then((value) =>
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LeafsInfoView(
                          this.controller.getLeafs(),
                          this.controller.getSearch()[index].name,
                          this.controller)));
        }));
  }

  int length() {
    if (controller.getSearch() != null)
      return controller
          .getSearch()
          .length;
    else
      return 0;
  }

  void setLeafs(int index) {
    setState(() {
      visual(index, (parsedJson) => LeafInfo(parsedJson));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        backgroundColor: Colors.red,
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Flexible(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: length(),
              itemBuilder: (context, index) {
                return FlatButton(
                  child: ListTile(
                    title: Text(
                        '${controller.getSearch()[index].name.toString()}'),
                    subtitle: Text(
                        '${controller.getSearch()[index].description
                            .toString()}'),
                  ),
                  onPressed: () {
                    setLeafs(index);
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
            ),
          ),
        ],
      ),
    );
  }
}
