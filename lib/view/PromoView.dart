import 'package:MC/controller/Controller.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class PromoView extends StatefulWidget {
  Controller controller;

  PromoView(this.controller);

  @override
  _PromoViewState createState() => _PromoViewState(this.controller);
}

class _PromoViewState extends State<PromoView> {
  Controller controller;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _PromoViewState(this.controller);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      header: ClassicHeader(),
      controller: _refreshController,
      onRefresh: () => setState(() {
        this.controller.initPromos().then((value) {
          (context as Element).reassemble();
          _refreshController.refreshCompleted();
        });
      }),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: this.controller.getPromos().length,
        itemBuilder: (context, index) {
          return FlatButton(
              child: ListTile(
                title: Text(this.controller.getPromos()[index].name),
                subtitle: Text(this.controller.getPromos()[index].description),
              ),
              onPressed: () async {
                if (await canLaunch(this.controller.getPromos()[index].url)) {
                  await launch(this.controller.getPromos()[index].url);
                } else {
                  throw 'Could not launch ${this.controller.getPromos()[index].url}';
                }
              });
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
