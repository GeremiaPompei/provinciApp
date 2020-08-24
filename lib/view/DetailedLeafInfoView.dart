import 'package:MC/controller/Controller.dart';
import 'package:MC/model/LeafInfo.dart';
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

class DetailedLeafInfoView extends StatefulWidget {
  LeafInfo leafInfo;
  String title;
  Controller controller;

  DetailedLeafInfoView(this.title, this.leafInfo, this.controller);

  @override
  _DetailedLeafInfoViewState createState() =>
      _DetailedLeafInfoViewState(this.title, this.leafInfo, this.controller);
}

class _DetailedLeafInfoViewState extends State<DetailedLeafInfoView> {
  LeafInfo leafInfo;
  String title;
  List<Widget> widgets;
  Controller controller;

  _DetailedLeafInfoViewState(this.title, this.leafInfo, this.controller) {
    initWidgets();
  }

  void initWidgets() => this.widgets = [
        Text(
          this.leafInfo.getName(),
          style: TextStyle(fontSize: 20),
        ),
        this.leafInfo.getDescription() == null
            ? Container()
            : Text(this.leafInfo.getDescription()),
        this.leafInfo.getImage() == null
            ? Container()
            : FlatButton(
                child: Image(image: NetworkImage(this.leafInfo.getImage())),
                onPressed: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Scaffold(
                                appBar: AppBar(
                                  backgroundColor: Colors.black,
                                  title: Text(this.leafInfo.getName()),
                                ),
                                body: Container(
                                  child: PhotoView(
                                    imageProvider:
                                        NetworkImage(this.leafInfo.getImage()),
                                  ),
                                ))));
                  });
                }),
        this.leafInfo.getTelefono() == null
            ? Container()
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
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
            : Column(
                children: <Widget>[
                  Container(
                    height: 400,
                    alignment: Alignment.centerLeft,
                    child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(this.leafInfo.getPosition()[0],
                            this.leafInfo.getPosition()[1]),
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
                              point: LatLng(this.leafInfo.getPosition()[0],
                                  this.leafInfo.getPosition()[1]),
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
                  this.leafInfo.getPosition() == null
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
          itemCount: this.leafInfo.getInfo().length,
          itemBuilder: (context, index) => ListTile(
            title: Text(this.leafInfo.getInfo().keys.toList()[index]),
            subtitle: Text(this.leafInfo.getInfo().values.toList()[index]),
          ),
        ),
        this.leafInfo.getUrl() == null
            ? Container()
            : ListTile(
                title: Text('Url'),
                subtitle: Linkify(
                  text: '${this.leafInfo.getUrl()}',
                  onOpen: (LinkableElement link) {
                    launch(this.leafInfo.getUrl());
                  },
                ),
              ),
        IconButton(
          icon: Icon(Icons.add_circle_outline),
          onPressed: () {
            this.controller.addOffline(leafInfo);
          },
        ),
        IconButton(
          icon: Icon(Icons.remove_circle_outline),
          onPressed: () {
            this.controller.removeOffline(leafInfo);
          },
        )
      ];

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
          this.leafInfo.getPosition()[0], this.leafInfo.getPosition()[1]);
      final title = this.leafInfo.getName();
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
