import 'package:MC/controller/Controller.dart';
import 'package:MC/utility/Style.dart';
import 'package:MC/view/LeafsInfoView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoadingView.dart';
import 'OfflineView.dart';
import 'SavedView.dart';

class ScrollListView extends StatefulWidget {
  Controller _controller;
  String _title;

  ScrollListView(this._controller, this._title);

  @override
  _ScrollListViewState createState() =>
      _ScrollListViewState(this._controller, this._title);
}

class _ScrollListViewState extends State<ScrollListView> {
  Controller _controller;
  String _title;
  Widget _varWidget;

  _ScrollListViewState(this._controller, this._title);

  int length() {
    if (_controller.getSearch() != null)
      return _controller.getSearch().length;
    else
      return 0;
  }

  void setLeafs(int index) {
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FutureBuilder<dynamic>(
                    future: _controller.setLeafInfo(
                        _controller.getSearch()[index].name,
                        _controller.getSearch()[index].url),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData)
                        _varWidget = LeafsInfoView(
                            this._controller.getLeafs(),
                            this._controller.getSearch()[index].name,
                            this._controller);
                      else if (snapshot.hasError)
                        _varWidget = SavedWidget(this._controller);
                      else
                        _varWidget = LoadingView();
                      return _varWidget;
                    },
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this._title),
        backgroundColor: ThemePrimaryColor,
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            }),
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
                return ListTile(
                  title:
                      Text('${_controller.getSearch()[index].name.toString()}'),
                  subtitle: Text(
                      '${_controller.getSearch()[index].description.toString()}'),
                  onTap: () {
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
