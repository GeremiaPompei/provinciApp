import 'package:MC/view/HomeView.dart';
import 'package:flutter/material.dart';

import 'controller/Controller.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeView(
          Controller(),
        ),
      ),
    );
