

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

  Navigation navigation;

  _NotifierState({this.navigation});

  //Symbol data from search.dart
  Map data = {};
  
  @override
  Widget build(BuildContext context) {
    
    //Symbol data from search.dart
    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
          backgroundColor: Colours.blue2,
          body: Stack(
                children: <Widget>[
                  Container(
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
                            child: Column(
                              children: <Widget>[

//-------------------------------------------------- Symbol & Close Button

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      '${data['symbol']}',
                                      style: TextStyle(
                                        fontSize: 28.0,
                                        fontWeight: FontWeight.w700,
                                        color: Colours.white13,
                                      ),
                                    ),
                                  ),
                                  IconButton(onPressed: () {Navigator.pop(context);},icon: Icon(Icons.close), color: Colors.white),
                                  ]),

//-------------------------------------------------- Company Name

                                Row(children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      '${data['companyname']}',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.w300,
                                        color: Colours.blue5,
                                      ),
                                      ),
                                  ),
                                ]),
                              ],),
                          ),

                          SizedBox(height: 150.0,),

//-------------------------------------------------- Notifier Menu Panel Stack
                          
                          Stack(
                            children: <Widget>[
                              
                              Column( children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                  child: Row(children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 2.0),
                                      child: Text(
                                        'Choose Chart Interval'.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.0,
                                          color: Colours.white13,
                                        ),
                                        ),
                                    ),
                                  ]),
                                ),
                                Divider(color: Colours.blue4,),
                              ]),

                              Column( children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                  child: Row(children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 2.0),
                                      child: Text(
                                        'Choose Chart Interval'.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.0,
                                          color: Colours.white13,
                                        ),
                                        ),
                                    ),
                                  ]),
                                ),
                                Divider(color: Colours.blue4,),
                              ]),

                            
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),

//-------------------------------------------------- Notifier Creation Navigation

                  Align(
                            alignment: Alignment.bottomCenter,
                            child: SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[

//-------------------------------------------------- Bottom Navigation

                                  IconButton(
                                    onPressed: () {
                                      appData.text += 1;
                                      print(appData.text);
                                    },
                                    icon: Icon(Icons.arrow_back_ios, color: Colours.white13,),
                                  ),
                                  GestureDetector(
                                    onTap: () {

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Continue'.toUpperCase(),
                                        style: TextStyle(
                                          color: Colours.white13,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5,
                                        ),


                                      ),
                                    ),
                                    ),
                                ]),
                              ),
                            ),
                          ),

            ],
          ),
    );
  }
}



/*........................................... Program ......................................*/
