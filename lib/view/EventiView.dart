import 'package:MC/controller/Controller.dart';
import 'package:MC/utility/Colore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EventiView extends StatefulWidget {
  Controller controller;

  EventiView(this.controller);

  @override
  _EventiViewState createState() => _EventiViewState(this.controller);
}

class _EventiViewState extends State<EventiView> {
  Controller controller;
  Widget varWidget;

  _EventiViewState(this.controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text('Eventi'), backgroundColor: Colore.primario()),
        body: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Flexible(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: this.controller.getEvents().length,
                itemBuilder: (context, index) {
                  return FlatButton(
                      child: ListTile(
                        title: Text(
                            this.controller.getEvents()[index].name.toString()),
                        subtitle: Text(this
                            .controller
                            .getEvents()[index]
                            .description
                            .toString()),
                      ),
                      onPressed: () async {
                        if (await canLaunch(
                            this.controller.getEvents()[index].url)) {
                          await launch(this.controller.getEvents()[index].url);
                        } else {
                          throw 'Could not launch ${this.controller.getEvents()[index].url}';
                        }
                      });
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
          ],
        ));
  }
}
