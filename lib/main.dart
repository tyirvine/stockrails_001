

//Flutter SDK
import 'package:flutter/material.dart';

//Project Pages
import 'package:stockrails_001/pages/home.dart';
import 'package:stockrails_001/pages/notifiermenu.dart';
import 'package:stockrails_001/pages/search.dart';
import 'package:stockrails_001/pages/notifier.dart';


/*........................................... Program ......................................*/

void main() => runApp(MaterialApp(
  initialRoute: '/search',
  routes: {
    '/home': (context) => Home(),
    '/search': (context) => Search(),
    '/notifier': (context) => Notifier(),
    '/notifiermenu': (context) => NotifierMenu(),
  },
));




