import 'package:MC/controller/Controller.dart';
import 'package:MC/model/LeafInfo.dart';
import 'package:MC/utility/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:latlong/latlong.dart';
import 'package:map_launcher/map_launcher.dart' as mapLauncher;
import 'package:map_launcher/map_launcher.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

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
  Map<String, Widget> widgets;
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

  void initWidgets() => this.widgets = {
        'Image': this.image == null
            ? Container()
            : Container(
                width: 150.0,
                height: 150.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: this.image.image,
                    ))),
        'Name': Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: BackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              )),
          child: Text(
            this.leafInfo.name,
            style: TitleDetaileStyle,
          ),
        ),
        'Description': this.leafInfo.description == null
            ? null
            : Text(this.leafInfo.description),
        'Phone': this.leafInfo.telefono == null
            ? null
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: this.leafInfo.telefono.length,
                itemBuilder: (context, index) => FlatButton(
                      onPressed: () async {
                        await FlutterPhoneDirectCaller.callNumber(
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
        'Email': this.leafInfo.email == null
            ? null
            : CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    await launch('mailto:${this.leafInfo.email}');
                  },
                ),
              ),
        'PositionIcon': this.leafInfo.position == null
            ? null
            : CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () => openMapsSheet(context),
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.black,
                  ),
                ),
              ),
        'Position': this.leafInfo.position == null
            ? Container()
            : Container(
                height: 200,
                alignment: Alignment.centerLeft,
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(
                        this.leafInfo.position[0], this.leafInfo.position[1]),
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
        'Info': this.leafInfo.info.isEmpty
            ? null
            : ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: this.leafInfo.info.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(this.leafInfo.info.keys.toList()[index]),
                  subtitle: Linkify(
                    text: '${this.leafInfo.info.values.toList()[index]}',
                    onOpen: (LinkableElement link) async {
                      if (await canLaunch(
                          this.leafInfo.info.values.toList()[index]))
                        await launch(this.leafInfo.info.values.toList()[index]);
                    },
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
        'Url': this.leafInfo.url == null
            ? null
            : CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: Icon(
                    Icons.link,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    launch(this.leafInfo.url);
                  },
                ),
              ),
      };

  @override
  Widget build(BuildContext context) {
    List<Widget> listW = [
      this.widgets['Email'],
      this.widgets['PositionIcon'],
      this.widgets['Url'],
    ];
    listW.removeWhere((element) => element == null);
    return Scaffold(
        backgroundColor: ThemePrimaryColor,
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: this.leafInfo.url != null
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
                actions: <Widget>[
                  IconButton(
                    icon: this.icon,
                    onPressed: () {
                      setState(() {
                        if (this
                            ._controller
                            .getOffline()
                            .contains(this.leafInfo)) {
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
              this.widgets['Image'],
              SizedBox(
                height: 20,
              ),
              this.widgets['Name'],
              SizedBox(
                height: 20,
              ),
              containerRound(this.widgets['Description'], null),
              containerRound(this.widgets['Info'], 'Info'),
              containerRound(this.widgets['Phone'], 'Telefono'),
              this.widgets['Position'],
              SizedBox(
                height: 20,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: listW),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        )));
  }

  Widget containerRound(Widget child, String title) => child != null
      ? Column(children: [
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: BackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: ListTile(
              title: title == null ? null : Text(title,style: TitleDetaileStyle,),
              subtitle: child,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ])
      : Container();

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
