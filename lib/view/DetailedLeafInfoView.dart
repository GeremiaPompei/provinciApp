import 'package:MC/model/LeafInfo.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedLeafInfoView extends StatefulWidget {
  LeafInfo leafInfo;
  String title;

  DetailedLeafInfoView(this.title, this.leafInfo);

  @override
  _DetailedLeafInfoViewState createState() =>
      _DetailedLeafInfoViewState(this.title, this.leafInfo);
}

class _DetailedLeafInfoViewState extends State<DetailedLeafInfoView> {
  LeafInfo leafInfo;
  String title;

  _DetailedLeafInfoViewState(this.title, this.leafInfo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.leafInfo.getName()),
          backgroundColor: Colors.red,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            this.leafInfo.getUrl() != null
                ? IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      setState(() {
                        final RenderBox box = context.findRenderObject();
                        Share.share(this.leafInfo.getUrl(),
                            subject: this.title,
                            sharePositionOrigin:
                                box.localToGlobal(Offset.zero) & box.size);
                      });
                    },
                  )
                : Container()
          ],
        ),
        body: Flex(direction: Axis.vertical, children: <Widget>[
          Flexible(
              child: Center(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Text(
                  this.leafInfo.getName(),
                  style: TextStyle(fontSize: 20),
                ),
                this.leafInfo.getDescription() == null
                    ? Container()
                    : Text(this.leafInfo.getDescription()),
                this.leafInfo.getImage() == null
                    ? Container()
                    : Image(image: NetworkImage(this.leafInfo.getImage())),
                this.leafInfo.getTelefono() == null
                    ? Container()
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: this.leafInfo.getTelefono().length,
                        itemBuilder: (context, index) => FlatButton(
                              onPressed: () async {
                                FlutterPhoneDirectCaller.callNumber(
                                    '${this.leafInfo.getTelefono()[index]}');
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    (Icons.call),
                                  ),
                                  Text('${this.leafInfo.getTelefono()[index]}')
                                ],
                              ),
                            )),
                this.leafInfo.getEmail() == null
                    ? Container()
                    : FlatButton(
                        onPressed: () async {
                          await launch('mailto:${this.leafInfo.getEmail()}');
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              (Icons.email),
                            ),
                            Text('${this.leafInfo.getEmail()}')
                          ],
                        ),
                      ),
                this.leafInfo.getPosition() == null
                    ? Container()
                    : IconButton(
                        onPressed: () async {
                          launch(
                              "comgooglemaps://?center=${this.leafInfo.getPosition()[0]},${this.leafInfo.getPosition()[1]}");
                        },
                        icon: Icon(
                          (Icons.map),
                        ),
                      ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: this.leafInfo.getInfo().length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(this.leafInfo.getInfo().keys.toList()[index]),
                    subtitle:
                        Text(this.leafInfo.getInfo().values.toList()[index]),
                  ),
                ),
                this.leafInfo.getUrl() == null
                    ? Container()
                    : ListTile(
                        title: Text('Link'),
                        subtitle: Linkify(
                          text: '${this.leafInfo.getUrl()}',
                          onOpen: (LinkableElement link) {
                            launch(this.leafInfo.getUrl());
                          },
                        ),
                      )
              ],
            ),
          ))
        ]));
  }
}
