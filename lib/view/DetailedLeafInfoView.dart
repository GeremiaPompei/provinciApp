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
  LeafInfo _leafInfo;
  String _title;
  Controller _controller;
  Image _image;

  DetailedLeafInfoView(
      this._title, this._leafInfo, this._controller, this._image);

  @override
  _DetailedLeafInfoViewState createState() => _DetailedLeafInfoViewState(
      this._title, this._leafInfo, this._controller, this._image);
}

class _DetailedLeafInfoViewState extends State<DetailedLeafInfoView> {
  LeafInfo _leafInfo;
  String _title;
  Map<String, Widget> _widgets;
  Controller _controller;
  Icon _icon;
  Image _image;

  _DetailedLeafInfoViewState(
      this._title, this._leafInfo, this._controller, this._image) {
    this._controller.getOffline().contains(this._leafInfo)
        ? this._icon = Icon(Icons.remove_circle_outline)
        : this._icon = Icon(Icons.add_circle_outline);
    initWidgets();
  }

  void initWidgets() => this._widgets = {
        'Image': this._image == null
            ? Container()
            : Container(
                width: 150.0,
                height: 150.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: this._image.image,
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
            this._leafInfo.name,
            style: TitleDetaileStyle,
            textAlign: TextAlign.center,
          ),
        ),
        'Description': this._leafInfo.description == null
            ? null
            : Text(
                this._leafInfo.description,
                textAlign: TextAlign.center,
              ),
        'Phone': this._leafInfo.telefono == null
            ? null
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: this._leafInfo.telefono.length,
                itemBuilder: (context, index) => FlatButton(
                      onPressed: () async {
                        await FlutterPhoneDirectCaller.callNumber(
                            '${this._leafInfo.telefono[index]}');
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.call,
                            color: DarkColor,
                          ),
                          Text('${this._leafInfo.telefono[index]}')
                        ],
                      ),
                    )),
        'Email': this._leafInfo.email == null
            ? null
            : CircleAvatar(
                radius: 20,
                backgroundColor: BackgroundColor,
                child: IconButton(
                  icon: Icon(
                    Icons.email,
                    color: DarkColor,
                  ),
                  onPressed: () async {
                    await launch('mailto:${this._leafInfo.email}');
                  },
                ),
              ),
        'Share': this._leafInfo.url != null
            ? CircleAvatar(
                radius: 20,
                backgroundColor: BackgroundColor,
                child: IconButton(
                  icon: Icon(
                    Icons.share,
                    color: DarkColor,
                  ),
                  onPressed: () {
                    setState(() {
                      final RenderBox box = context.findRenderObject();
                      Share.share(this._leafInfo.url,
                          subject: this._title,
                          sharePositionOrigin:
                              box.localToGlobal(Offset.zero) & box.size);
                    });
                  },
                ))
            : null,
        'PositionIcon': this._leafInfo.position == null
            ? null
            : CircleAvatar(
                radius: 20,
                backgroundColor: BackgroundColor,
                child: IconButton(
                  onPressed: () => openMapsSheet(context),
                  icon: Icon(
                    Icons.location_on,
                    color: DarkColor,
                  ),
                ),
              ),
        'Position': this._leafInfo.position == null
            ? Container()
            : Container(
                height: 200,
                alignment: Alignment.centerLeft,
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(
                        this._leafInfo.position[0], this._leafInfo.position[1]),
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
                          point: LatLng(this._leafInfo.position[0],
                              this._leafInfo.position[1]),
                          builder: (ctx) => Container(
                            child: Icon(
                              Icons.location_on,
                              color: DarkColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        'Info': this._leafInfo.info.isEmpty
            ? null
            : ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: this._leafInfo.info.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    this._leafInfo.info.keys.toList()[index],
                  ),
                  subtitle: Linkify(
                    text: '${this._leafInfo.info.values.toList()[index]}',
                    onOpen: (LinkableElement link) async {
                      if (await canLaunch(
                          this._leafInfo.info.values.toList()[index]))
                        await launch(
                            this._leafInfo.info.values.toList()[index]);
                    },
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
        'Url': this._leafInfo.url == null
            ? null
            : CircleAvatar(
                radius: 20,
                backgroundColor: BackgroundColor,
                child: IconButton(
                  icon: Icon(
                    Icons.link,
                    color: DarkColor,
                  ),
                  onPressed: () {
                    launch(this._leafInfo.url);
                  },
                ),
              ),
      };

  @override
  Widget build(BuildContext context) {
    List<Widget> listW = [
      this._widgets['Email'],
      this._widgets['PositionIcon'],
      this._widgets['Url'],
      this._widgets['Share'],
    ];
    listW.removeWhere((element) => element == null);
    return Scaffold(
        backgroundColor: PrimaryColor,
        body: Padding(
            padding: EdgeInsets.fromLTRB(0, 22, 0, 0),
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: BackgroundColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: this._icon,
                        onPressed: () {
                          setState(() {
                            if (this
                                ._controller
                                .getOffline()
                                .contains(this._leafInfo)) {
                              this._controller.removeOffline(_leafInfo);
                              this._icon = Icon(Icons.add_circle_outline);
                            } else {
                              this._controller.addOffline(_leafInfo);
                              this._icon = Icon(Icons.remove_circle_outline);
                            }
                          });
                        },
                      )
                    ],
                  ),
                  this._widgets['Image'],
                  SizedBox(
                    height: 20,
                  ),
                  this._widgets['Name'],
                  SizedBox(
                    height: 20,
                  ),
                  containerRound(this._widgets['Description'], null),
                  containerRound(this._widgets['Info'], 'Info'),
                  containerRound(this._widgets['Phone'], 'Telefono'),
                  this._widgets['Position'],
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
            ))));
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
              title: title == null
                  ? null
                  : Text(
                      title,
                      style: TitleDetaileStyle,
                    ),
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
          this._leafInfo.position[0], this._leafInfo.position[1]);
      final title = this._leafInfo.name;
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
