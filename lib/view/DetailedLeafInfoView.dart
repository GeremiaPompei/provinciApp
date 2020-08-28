import 'package:MC/controller/Controller.dart';
import 'package:MC/model/LeafInfo.dart';
import 'package:MC/model/Web/HttpRequest.dart';
import 'package:MC/utility/Colore.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:map_launcher/map_launcher.dart' as mapLauncher;
import 'package:map_launcher/map_launcher.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'LoadingView.dart';

class DetailedLeafInfoView extends StatefulWidget {
  LeafInfo leafInfo;
  String title;
  Controller controller;
  Image image;

  DetailedLeafInfoView(this.title, this.leafInfo, this.controller, this.image);

  @override
  _DetailedLeafInfoViewState createState() => _DetailedLeafInfoViewState(
      this.title, this.leafInfo, this.controller, this.image);
}

class _DetailedLeafInfoViewState extends State<DetailedLeafInfoView> {
  LeafInfo leafInfo;
  String title;
  List<Widget> widgets;
  Controller _controller;
  Icon icon;
  Image image;

  _DetailedLeafInfoViewState(
      this.title, this.leafInfo, this._controller, this.image) {
    this._controller.getOffline().contains(this.leafInfo)
        ? this.icon = Icon(Icons.remove_circle_outline)
        : this.icon = Icon(Icons.add_circle_outline);
    initWidgets();
  }

  void initWidgets() => this.widgets = [
        Text(
          this.leafInfo.name,
          style: TextStyle(fontSize: 20),
        ),
        this.leafInfo.description == null
            ? Container()
            : Text(this.leafInfo.description),
        this.image == null
            ? Container()
            : FlatButton(
                child: this.image,
                onPressed: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Scaffold(
                                appBar: AppBar(
                                  backgroundColor: Colore.terziario(),
                                  title: Text(this.leafInfo.name),
                                ),
                                body: Container(child: this.image))));
                  });
                }),
        this.leafInfo.telefono == null
            ? Container()
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: this.leafInfo.telefono.length,
                itemBuilder: (context, index) => FlatButton(
                      onPressed: () async {
                        FlutterPhoneDirectCaller.callNumber(
                            '${this.leafInfo.telefono[index]}');
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            (Icons.call),
                          ),
                          Text('${this.leafInfo.telefono[index]}')
                        ],
                      ),
                    )),
        this.leafInfo.email == null
            ? Container()
            : FlatButton(
                onPressed: () async {
                  await launch('mailto:${this.leafInfo.email}');
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      (Icons.email),
                    ),
                    Text('${this.leafInfo.email}')
                  ],
                ),
              ),
        this.leafInfo.position == null
            ? Container()
            : Column(
                children: <Widget>[
                  Container(
                    height: 400,
                    alignment: Alignment.centerLeft,
                    child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(this.leafInfo.position[0],
                            this.leafInfo.position[1]),
                        zoom: 13.0,
                      ),
                      layers: [
                        new TileLayerOptions(
                            urlTemplate:
                                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c']),
                        new MarkerLayerOptions(
                          markers: [
                            new Marker(
                              width: 80.0,
                              height: 80.0,
                              point: LatLng(this.leafInfo.position[0],
                                  this.leafInfo.position[1]),
                              builder: (ctx) => Container(
                                child: Icon(
                                  (Icons.location_on),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  this.leafInfo.position == null
                      ? Container()
                      : FlatButton(
                          onPressed: () => openMapsSheet(context),
                          child: Text(
                            ('Apri in Mappe'),
                          ),
                        ),
                ],
              ),
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          itemCount: this.leafInfo.info.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(this.leafInfo.info.keys.toList()[index]),
            subtitle: Linkify(
              text: '${this.leafInfo.info.values.toList()[index]}',
              onOpen: (LinkableElement link) async {
                if (await canLaunch(this.leafInfo.info.values.toList()[index]))
                  await launch(this.leafInfo.info.values.toList()[index]);
              },
            ),
          ),
        ),
        this.leafInfo.url == null
            ? Container()
            : ListTile(
                title: Text('Url'),
                subtitle: Linkify(
                  text: '${this.leafInfo.url}',
                  onOpen: (LinkableElement link) {
                    launch(this.leafInfo.url);
                  },
                ),
              ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.leafInfo.name),
          backgroundColor: Colore.primario(),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            this.leafInfo.url != null
                ? IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      setState(() {
                        final RenderBox box = context.findRenderObject();
                        Share.share(this.leafInfo.url,
                            subject: this.title,
                            sharePositionOrigin:
                                box.localToGlobal(Offset.zero) & box.size);
                      });
                    },
                  )
                : Container(),
            IconButton(
              icon: this.icon,
              onPressed: () {
                setState(() {
                  if (this._controller.getOffline().contains(this.leafInfo)) {
                    this._controller.removeOffline(leafInfo);
                    this.icon = Icon(Icons.add_circle_outline);
                  } else {
                    this._controller.addOffline(leafInfo);
                    this.icon = Icon(Icons.remove_circle_outline);
                  }
                });
              },
            )
          ],
        ),
        body: Flex(direction: Axis.vertical, children: <Widget>[
          Flexible(
              child: Center(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: this.widgets.length,
              itemBuilder: (context, index) {
                return this.widgets[index];
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ))
        ]));
  }

  openMapsSheet(context) async {
    try {
      final coords = mapLauncher.Coords(
          this.leafInfo.position[0], this.leafInfo.position[1]);
      final title = this.leafInfo.name;
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                        ),
                        title: Text(map.mapName),
                        leading: Image(
                          image: map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
