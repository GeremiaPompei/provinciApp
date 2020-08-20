import 'package:MC/model/NodeInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PromoView extends StatefulWidget {
  List<NodeInfo> list;

  PromoView(this.list);

  @override
  _PromoViewState createState() => _PromoViewState(this.list);
}

class _PromoViewState extends State<PromoView> {
  List<NodeInfo> list;

  _PromoViewState(this.list);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Flexible(
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: this.list.length,
            itemBuilder: (context, index) {
              return FlatButton(
                  child: ListTile(
                    title: Text(this.list[index].name),
                    subtitle: Text(this.list[index].description),
                  ),
                  onPressed: () async {
                    if (await canLaunch(this.list[index].url)) {
                      await launch(this.list[index].url);
                    } else {
                      throw 'Could not launch ${this.list[index].url}';
                    }
                  });
            },
            separatorBuilder: (BuildContext context, int index) =>
            const Divider(),
          ),
        ),
      ],
    );
  }
}
