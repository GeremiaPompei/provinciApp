import 'package:MC/controller/Controller.dart';
import 'package:MC/view/OrganizationView.dart';
import 'package:MC/view/SearchView.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'CategoryView.dart';

void mtrApp() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Login...'),
      ),
      body: Center(
        child: FlatButton(
          child: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.red,
          onPressed: (){
            Controller controller = new Controller();
            Launcher().launch('MC Search...', SearchView(controller),controller: controller);
          },
        ),
      ),
    ),
  ));
}

class ButtonBarDown extends StatefulWidget {
  Controller controller;
  void Function(String title, Widget widget) launch;

  ButtonBarDown(this.controller, this.launch);

  @override
  _ButtonBarDownState createState() => _ButtonBarDownState(controller, launch);
}

class _ButtonBarDownState extends State<ButtonBarDown> {
  Controller controller;
  void Function(String title, Widget widget) launch;
  int index = 0;

  _ButtonBarDownState(this.controller, this.launch);

  void onItemTapped(index) {
    setState(() {
      this.index = index;
      switch (this.index) {
        case 0:
          launch('MC Search...', SearchView(controller));
          break;
        case 1:
          launch('MC Organizations...', organizationView(controller));
          break;
        case 2:
          launch('MC Category...', categoryView(controller));
          break;
        case 3:
          launch('MC Comment...', Center(child: Icon(Icons.comment)));
          break;
        case 4:
          launch('MC Settings...', Center(child: Icon(Icons.settings)));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('Search'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_city),
          title: Text('Organizations'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          title: Text('Categories'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.comment),
          title: Text('Comment'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings'),
        ),
      ],
      unselectedItemColor: Colors.black,
      currentIndex: index,
      selectedItemColor: Colors.red,
      onTap: onItemTapped,
    );
  }
}

class Launcher {
  Controller controller;
  ButtonBarDown bar;

  Launcher() {
    this.controller = new Controller();
    this.bar = new ButtonBarDown(controller, launch);
  }

  void launch(String title, Widget widget, {Controller controller}) {
    {
      this.controller = controller;
    }
    runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(title),
        ),
        body: widget,
        bottomNavigationBar: bar,
      ),
    ));
  }
}
