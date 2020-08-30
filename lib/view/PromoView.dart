import 'package:MC/controller/Controller.dart';
import 'package:MC/utility/Colore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PromoView extends StatefulWidget {
  Controller controller;

  PromoView(this.controller);

  @override
  _PromoViewState createState() => _PromoViewState(this.controller);
}

class _PromoViewState extends State<PromoView> {
  Controller controller;

  _PromoViewState(this.controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Promo'),
          backgroundColor: Colore.primario(),
        ),
        body: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Flexible(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: this.controller.getPromos().length,
                itemBuilder: (context, index) {
                  return FlatButton(
                      child: ListTile(
                        title: Text(this.controller.getPromos()[index].name),
                        subtitle: Text(
                            this.controller.getPromos()[index].description),
                      ),
                      onPressed: () async {
                        if (await canLaunch(
                            this.controller.getPromos()[index].url)) {
                          await launch(this.controller.getPromos()[index].url);
                        } else {
                          throw 'Could not launch ${this.controller.getPromos()[index].url}';
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
