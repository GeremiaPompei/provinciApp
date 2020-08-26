import 'package:MC/controller/Controller.dart';
import 'package:MC/model/UnitCache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastSearchedWidget extends StatefulWidget {
  Controller controller;
  List<MapEntry<String, UnitCache>> list;
  Widget Function(int index) funcWidget;
  Future Function(int index) funcSet;

  LastSearchedWidget(this.controller, this.list, this.funcWidget, this.funcSet);

  @override
  _LastSearchedWidgetState createState() => _LastSearchedWidgetState(
      this.controller, this.list, this.funcWidget, this.funcSet);
}

class _LastSearchedWidgetState extends State<LastSearchedWidget> {
  Controller controller;
  List<MapEntry<String, UnitCache>> list;
  Widget Function(int index) funcWidget;
  Future Function(int index) funcSet;

  _LastSearchedWidgetState(
      this.controller, this.list, this.funcWidget, this.funcSet);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: this.list.length,
        itemBuilder: (context, index) =>
            this.list[index].value.name.contains('Empty')
                ? Container()
                : FlatButton(
                    child: ListTile(
                      title: Text(this.list[index].value.name),
                      subtitle: Text(DateFormat('yyy-MM-dd HH:mm')
                          .format(this.list[index].value.date)
                          .toString()),
                    ),
                    onPressed: () {
                      funcSet(index).then((value) => setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => funcWidget(index)));
                          }));
                    },
                  ));
  }
}
