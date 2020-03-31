

//Flutter SDK
import 'package:flutter/material.dart';

//Global Data
import 'package:stockrails_001/data.dart';


/*........................................... Program ......................................*/

class Notifier extends StatefulWidget {
  @override
  _NotifierState createState() => _NotifierState();
}

class _NotifierState extends State<Notifier> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colours.blue2,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(onPressed: () {Navigator.pop(context);},icon: Icon(Icons.close)),
                  
                ],),
            ],
          ),
    );
  }
}