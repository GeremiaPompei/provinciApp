import 'package:MC/controller/Controller.dart';
import 'package:MC/utility/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'DetailedLeafInfoView.dart';

class SavedWidget extends StatefulWidget {
  Controller _controller;

  SavedWidget(this._controller);

  @override
  _SavedWidgetState createState() => _SavedWidgetState(this._controller);
}

class _SavedWidgetState extends State<SavedWidget> {
  Controller _controller;
  RefreshController _refreshController;

  _SavedWidgetState(this._controller) {
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: AppBar(
        title: Text(
          'Offline',
          style: ReverseTitleTextStyle,
        ),
        backgroundColor: ThemePrimaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.file_upload),
            onPressed: () async {
              if (await this._controller.tryConnection())
                Navigator.pushReplacementNamed(context, '/online');
            },
          ),
        ],
      ),
      body: SmartRefresher(
        enablePullDown: true,
        header: ClassicHeader(),
        controller: _refreshController,
        onRefresh: () => setState(() {
          this._controller.initOffline().then((value) {
            (context as Element).reassemble();
            _refreshController.refreshCompleted();
          });
        }),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: this._controller.getOffline().length,
          itemBuilder: (context, index) {
            Icon icon;
            this
                    ._controller
                    .getOffline()
                    .contains(this._controller.getOffline()[index])
                ? icon = Icon(Icons.remove_circle_outline)
                : icon = Icon(Icons.add_circle_outline);
            return Card(
                child: ListTile(
                    trailing: IconButton(
                      icon: icon,
                      onPressed: () {
                        setState(() {
                          if (this
                              ._controller
                              .getOffline()
                              .contains(this._controller.getOffline()[index])) {
                            this._controller.removeOffline(
                                this._controller.getOffline()[index]);
                            icon = Icon(Icons.add_circle_outline);
                          } else {
                            this._controller.addOffline(
                                this._controller.getOffline()[index]);
                            icon = Icon(Icons.remove_circle_outline);
                          }
                        });
                      },
                    ),
                    leading:
                        this._controller.getOffline()[index].imageFile == null
                            ? null
                            : Image.file(
                                this._controller.getOffline()[index].imageFile),
                    title: Text('${this._controller.getOffline()[index].name}'),
                    subtitle: this
                                ._controller
                                .getOffline()
                                .toList()[index]
                                .description ==
                            null
                        ? Text('')
                        : Text(
                            '${this._controller.getOffline()[index].description}'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailedLeafInfoView(
                                    this._controller.getOffline()[index].name,
                                    this._controller.getOffline()[index],
                                    _controller,
                                    this
                                                ._controller
                                                .getOffline()[index]
                                                .imageFile ==
                                            null
                                        ? null
                                        : Image.file(
                                            this
                                                ._controller
                                                .getOffline()[index]
                                                .imageFile,
                                          ),
                                  )));
                    }));
          },
        ),
      ),
    );
  }
}
