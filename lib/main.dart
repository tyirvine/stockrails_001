
import 'package:flutter/material.dart';
import 'package:stockrails_001/pages/home.dart';
import 'package:stockrails_001/pages/loading.dart';



void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home(),
  },
));


