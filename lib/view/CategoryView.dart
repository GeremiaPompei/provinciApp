import 'package:MC/controller/Controller.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class categoryView extends StatefulWidget {
  Controller controller;

  categoryView(this.controller);

  @override
  _categoryViewState createState() => _categoryViewState(controller);
}

class _categoryViewState extends State<categoryView> {
  Controller controller;

  _categoryViewState(this.controller);

  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: controller.getCategories().length,
      itemBuilder: (context, index) {
        return FlatButton(
          child: ListTile(
              title: Text(controller.getCategories()[index].name.toString())
          ),
          onPressed: () {
            setState(() {
              print(controller.getCategories()[index].url);
            });
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
