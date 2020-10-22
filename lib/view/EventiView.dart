import 'package:provinciApp/controller/Controller.dart';
import 'package:provinciApp/utility/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

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
          backgroundColor: PrimaryColor),
      body: SmartRefresher(
        enablePullDown: true,
        header: ClassicHeader(),
        controller: _refreshController,
        onRefresh: () {
          this._controller.getEvents().removeWhere((element) => true);
          setState(() {
            this._controller.initEvents().then((value) {
              (context as Element).reassemble();
              _refreshController.refreshCompleted();
            });
          });
        },
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: this._controller.getEvents().length,
          itemBuilder: (context, index) {
            return Container(
                child: ListTile(
                    title: Text(
                      this._controller.getEvents()[index].nome.toString(),
                      maxLines: 2,
                    ),
                    subtitle: Text(
                      this
                          ._controller
                          .getEvents()[index]
                          .descrizione
                          .toString(),
                      maxLines: 2,
                    ),
                    leading: this._controller.getEvents()[index].immagineUrl != null
                        ? Image(
                            image: NetworkImage(
                                this._controller.getEvents()[index].immagineUrl))
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
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: 10,
          ),
        ),
      ),
    );
  }
}
