import 'package:MC/controller/Controller.dart';
import 'package:MC/view/SearchView.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:MC/model/web/HttpRequest.dart';
import 'package:flutter/material.dart';

import 'BasicView.dart';

class organizationView extends StatefulWidget {
  Controller controller;

  organizationView(this.controller);

  @override
  _organizationViewState createState() => _organizationViewState(controller);
}

class _organizationViewState extends State<organizationView> {
  String result = '';
  Controller controller;

  _organizationViewState(this.controller);

  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: controller.getOrganizations().length,
      itemBuilder: (context, index) {
        return FlatButton(
          child: ListTile(
              title: Text(controller.getOrganizations()[index].name.toString()),
              subtitle: Text(
                  controller.getOrganizations()[index].description.toString())),
          onPressed: () {
            setState(() {
              controller
                  .setSearch(controller.getOrganizations()[index].url)
                  .then((value) => Launcher(controller).launch(
                      'MC Search...', SearchView(controller)));
            });
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
