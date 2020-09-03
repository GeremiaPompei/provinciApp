import 'package:MC/controller/Controller.dart';
import 'package:MC/utility/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import 'OfflineView.dart';

class EventiView extends StatefulWidget {
  Controller _controller;

  EventiView(this._controller);

  @override
  _EventiViewState createState() => _EventiViewState(this._controller);
}

class _EventiViewState extends State<EventiView> {
  Controller _controller;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _EventiViewState(this._controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Eventi',
            style: ReverseTitleTextStyle,
          ),
          backgroundColor: ThemePrimaryColor),
      body: SmartRefresher(
        enablePullDown: true,
        header: ClassicHeader(),
        controller: _refreshController,
        onRefresh: () => setState(() {
          this._controller.getEvents().removeWhere((element) => true);
          this._controller.initEvents().then((value) {
            (context as Element).reassemble();
            _refreshController.refreshCompleted();
          });
        }),
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: this._controller.getEvents().length,
          itemBuilder: (context, index) {
            return Container(
                color: BackgroundColor2,
                child: ListTile(
                    title: Text(
                        this._controller.getEvents()[index].name.toString()),
                    subtitle: Text(this
                        ._controller
                        .getEvents()[index]
                        .description
                        .toString()),
                    leading: this._controller.getEvents()[index].image != null
                        ? Image(
                            image: NetworkImage(
                                this._controller.getEvents()[index].image))
                        : null,
                    onTap: () async {
                      if (await canLaunch(
                          this._controller.getEvents()[index].url)) {
                        await launch(this._controller.getEvents()[index].url);
                      } else {
                        throw 'Could not launch ${this._controller.getEvents()[index].url}';
                      }
                    }));
          },
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: 10,),
        ),
      ),
    );
  }
}
