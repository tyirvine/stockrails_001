
import 'package:flutter/material.dart';
import 'package:stockrails_001/pages/home.dart';
import 'package:stockrails_001/pages/loading.dart';
import 'package:stockrails_001/pages/search.dart';



void main() => runApp(MaterialApp(
  initialRoute: '/search',
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/search': (context) => Search(),
  },
));




