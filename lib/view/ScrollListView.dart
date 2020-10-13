import 'package:MC/controller/Controller.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:MC/utility/Style.dart';
import 'package:MC/view/LeafsInfoView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'LoadingView.dart';
import 'OfflineView.dart';

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
  List<NodeInfo> _nodes;

  _ScrollListViewState(this._controller, this._title) {
    this._nodes = this._controller.getSearch();
  }

  void setLeafs(int index) {
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FutureBuilder<dynamic>(
                    future: _controller.setLeafInfo(_nodes[index].name,
                        _nodes[index].url, findImage(_nodes[index].name)),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      Widget tmpWidget;
                      if (snapshot.hasData)
                        tmpWidget = LeafsInfoView(
                            this._controller, this._nodes[index].name);
                      else if (snapshot.hasError)
                        tmpWidget = OfflineView(this._nodes[index].name);
                      else
                        tmpWidget = LoadingView();
                      return tmpWidget;
                    },
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: AppBar(
        title: Text(
          this._title,
          style: ReverseTitleTextStyle,
        ),
        backgroundColor: PrimaryColor,
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
              itemCount: this._nodes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    this._nodes[index].name,
                    maxLines: 2,
                  ),
                  subtitle: Text(
                    this._nodes[index].description.toString(),
                    maxLines: 2,
                  ),
                  leading: Stack(alignment: Alignment.center, children: [
                    Image.asset('assets/empty.png'),
                    Icon(
                      IconData(findImage(this._nodes[index].name),
                          fontFamily: 'MaterialIcons'),
                      color: BackgroundColor,
                    )
                  ]),
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
