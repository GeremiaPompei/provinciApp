import 'package:MC/model/NodeInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EventiView extends StatefulWidget {
  List<NodeInfo> list;

  EventiView(this.list);

  @override
  _EventiViewState createState() => _EventiViewState(this.list);
}

class _EventiViewState extends State<EventiView> {
  List<NodeInfo> list;

  _EventiViewState(this.list);

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
                    title: Text(this.list[index].name.toString()),
                    subtitle: Text(this.list[index].description.toString()),
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
