import 'package:MC/controller/Controller.dart';
import 'package:MC/utility/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class PromoView extends StatefulWidget {
  Controller _controller;

  PromoView(this._controller);

  @override
  _PromoViewState createState() => _PromoViewState(this._controller);
}

class _PromoViewState extends State<PromoView> {
  Controller _controller;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _PromoViewState(this._controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Promo'),
        backgroundColor: ThemePrimaryColor,
      ),
      body: SmartRefresher(
        enablePullDown: true,
        header: ClassicHeader(),
        controller: _refreshController,
        onRefresh: () => setState(() {
          this._controller.getPromos().removeWhere((element) => true);
          this._controller.initPromos().then((value) {
            (context as Element).reassemble();
            _refreshController.refreshCompleted();
          });
        }),
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: this._controller.getPromos().length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(this._controller.getPromos()[index].name),
                subtitle: Text(this._controller.getPromos()[index].description),
                leading: this._controller.getPromos()[index].image != null
                    ? Image(
                        image: NetworkImage(
                            this._controller.getPromos()[index].image))
                    : null,
                onTap: () async {
                  if (await canLaunch(
                      this._controller.getPromos()[index].url)) {
                    await launch(this._controller.getPromos()[index].url);
                  } else {
                    throw 'Could not launch ${this._controller.getPromos()[index].url}';
                  }
                });
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }
}
