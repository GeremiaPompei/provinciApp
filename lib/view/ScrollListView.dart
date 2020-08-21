import 'package:MC/controller/Controller.dart';
import 'package:MC/view/LeafsInfoView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MC/model/LeafInfo.dart';

import 'LoadingView.dart';

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
  Widget varWidget;

  _ScrollListViewState(this.controller, this.title);

  void visual(
      int index, LeafInfo Function(Map<String, dynamic> parsedJson) func) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FutureBuilder<dynamic>(
                  future: controller.setLeafInfo(
                      controller.getSearch()[index].getName(),
                      controller.getSearch()[index].getUrl(),
                      (el) => func(el)),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData)
                      varWidget = LeafsInfoView(
                          this.controller.getLeafs(),
                          this.controller.getSearch()[index].getName(),
                          this.controller);
                    else
                      varWidget = LoadingView();
                    return varWidget;
                  },
                )));
  }

  int length() {
    if (controller.getSearch() != null)
      return controller.getSearch().length;
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
                        '${controller.getSearch()[index].getName().toString()}'),
                    subtitle: Text(
                        '${controller.getSearch()[index].getDescription().toString()}'),
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
