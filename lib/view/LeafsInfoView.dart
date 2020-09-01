import 'package:MC/controller/Controller.dart';
import 'package:MC/model/LeafInfo.dart';
import 'package:MC/utility/Style.dart';
import 'package:MC/view/DetailedLeafInfoView.dart';
import 'package:flutter/material.dart';

class LeafsInfoView extends StatefulWidget {
  List<LeafInfo> _leafs;
  String _title;
  Controller _controller;

  LeafsInfoView(this._leafs, this._title, this._controller);

  @override
  _LeafsInfoViewState createState() =>
      _LeafsInfoViewState(this._leafs, this._title, this._controller);
}

class _LeafsInfoViewState extends State<LeafsInfoView> {
  List<LeafInfo> _leafs;
  String _title;
  Controller _controller;

  _LeafsInfoViewState(this._leafs, this._title, this._controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemePrimaryColor,
        title: Text(_title),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
      body: ButtonInfo(_leafs, _title, _controller),
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
  Controller _controller;

  _ButtonInfoState(this.leafs, this.title, this._controller);

  int length() {
    if (_controller.getLeafs() != null)
      return _controller.getLeafs().length;
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
          Icon icon;
          this._controller.getOffline().contains(leafs[index])
              ? icon = Icon(Icons.remove_circle_outline)
              : icon = Icon(Icons.add_circle_outline);
          return Card(
              child: ListTile(
                  trailing: IconButton(
                    icon: icon,
                    onPressed: () {
                      setState(() {
                        if (this
                            ._controller
                            .getOffline()
                            .contains(leafs[index])) {
                          this._controller.removeOffline(leafs[index]);
                          icon = Icon(Icons.add_circle_outline);
                        } else {
                          this._controller.addOffline(leafs[index]);
                          icon = Icon(Icons.remove_circle_outline);
                        }
                      });
                    },
                  ),
                  leading: leafs[index].image == null
                      ? null
                      : Image(
                          image:
                              NetworkImage('${leafs[index].image.toString()}')),
                  title: Text('${leafs[index].name}'),
                  subtitle: leafs[index].description == null
                      ? Text('')
                      : Text('${leafs[index].description}'),
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailedLeafInfoView(
                                    title,
                                    leafs[index],
                                    _controller,
                                    leafs[index].image == null
                                        ? null
                                        : Image(
                                            image: NetworkImage(
                                                '${leafs[index].image.toString()}')),
                                  )));
                    });
                  }));
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
