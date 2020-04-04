

//Flutter SDK
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Global Data
import 'package:stockrails_001/data.dart';

//Pages
import 'package:stockrails_001/custom/picker.dart' as my;


/*........................................... Program ......................................*/



class Notifier extends StatefulWidget {

  @override
  _NotifierState createState() => _NotifierState();
}

class _NotifierState extends State<Notifier> {

  //Notifier Data
  NotifierNavigation navigation;

  //Notifier Animations
  bool animateBackButton = false;
  bool animateFinishButton = false;

  bool animateNotifierPage0 = false;
  bool animateNotifierPage1 = false;
  bool animateNotifierPage2 = false;
  bool animateNotifierPage3 = false;

  _NotifierState({this.navigation});

  //Symbol data from search.dart
  Map data = {};
  


  //Program
  @override
  Widget build(BuildContext context) {
    
    
    //Symbol data from search.dart
    data = ModalRoute.of(context).settings.arguments;

    notifierPageSet() {
    if (notifierNavigationData.pageCount == 0) {
      setState(() {
      animateNotifierPage0 = true;
      animateNotifierPage1 = false;
      animateNotifierPage2 = false;
      animateNotifierPage3 = false;
      });
    }

    if (notifierNavigationData.pageCount == 1) {
      setState(() {
      animateNotifierPage0 = false;
      animateNotifierPage1 = true;
      animateNotifierPage2 = false;
      animateNotifierPage3 = false;
      });
    }

    if (notifierNavigationData.pageCount == 2) {
      setState(() {
      animateNotifierPage0 = false;
      animateNotifierPage1 = false;
      animateNotifierPage2 = true;
      animateNotifierPage3 = false;
      });
    }

    if (notifierNavigationData.pageCount == 3) {
      setState(() {
      animateNotifierPage0 = false;
      animateNotifierPage1 = false;
      animateNotifierPage2 = false;
      animateNotifierPage3 = true;
      });
    }
    }

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

                          Spacer(flex: 2),

//-------------------------------------------------- Notifier Menu Panel Stack
                          
                          Stack(
                            children: <Widget>[
                              

                              IgnorePointer(
                                ignoring: !animateNotifierPage0,
                                child: AnimatedOpacity(
                                  opacity: animateNotifierPage0 ? 1.0 : 0.0,
                                  duration: Duration(milliseconds: 250),
                                  child: Container(
                                    height: 450.0,
                                    child: Column( children: <Widget>[
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

//-------------------------------------------------- Cupertino Picker

                                      Container(
                                        height: 305.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            
                                            Container(
                                              alignment: Alignment.center,
                                              height: 275.0,
                                              width: 100.0,
                                              child: CupertinoTheme(
                                                data: CupertinoThemeData(
                                                  textTheme: CupertinoTextThemeData(
                                                    //Styling
                                                    pickerTextStyle: TextStyle(
                                                      color: Colours.white13,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 50.0
                                                    )
                                                  )
                                                ),
                                                child: my.CupertinoPicker(
                                                  backgroundColor: Color(0xFF5b8aea),
                                                  magnification: 0.9,
                                                  diameterRatio: 3.0,
                                                  itemExtent: 85.0,
                                                  onSelectedItemChanged: (int i) { print(i); },
                                                  children: <Widget> [
                                                    Center(child: Text('1')),
                                                    Center(child: Text('2')),
                                                    Center(child: Text('3')),
                                                    Center(child: Text('4')),
                                                    Center(child: Text('5')),
                                                    Center(child: Text('6')),
                                                    Center(child: Text('7')),
                                                    Center(child: Text('8')),
                                                    Center(child: Text('9')),
                                                    Center(child: Text('10')),
                                                ],),
                                              ),
                                            ),

                                            Container(
                                              height: 60.0,
                                              child: VerticalDivider(color: Colours.blue4),
                                              ),

                                            Container(
                                              alignment: Alignment.center,
                                              height: 300.0,
                                              width: 100.0,
                                              child: CupertinoTheme(
                                                data: CupertinoThemeData(
                                                  textTheme: CupertinoTextThemeData(
                                                    //Styling
                                                    pickerTextStyle: TextStyle(
                                                      color: Colours.white13,
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 20.0
                                                    )
                                                  )
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                                                  child: my.CupertinoPicker(
                                                    backgroundColor: Color(0xFF5b8aea),
                                                    magnification: 0.5,
                                                    diameterRatio: 3.0,
                                                    itemExtent: 50.0,
                                                    onSelectedItemChanged: (int i) { print(i); },
                                                    children: <Widget> [
                                                      Align(alignment: Alignment.centerLeft, child: Text('Hours')),
                                                      Align(alignment: Alignment.centerLeft, child: Text('Days')),
                                                      Align(alignment: Alignment.centerLeft, child: Text('Weeks')),
                                                      Align(alignment: Alignment.centerLeft, child: Text('Months')),
                                                  ],),
                                                ),
                                              ),
                                            ),

                                          
                                          
                                          ],
                                        ),
                                      )

                                      


                                    ]),
                                  ),
                                ),
                              ),




                              IgnorePointer(
                                ignoring: !animateNotifierPage1,
                                child: AnimatedOpacity(
                                  opacity: animateNotifierPage1 ? 1.0 : 0.0,
                                  duration: Duration(milliseconds: 250),
                                  child: Column( children: <Widget>[
                                      Padding(
                                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                      child: Row(children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 2.0),
                                          child: Text(
                                            'Notify me when there are...'.toUpperCase(),
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
                                    Container(
                                      alignment: Alignment.center,
                                      color: Colors.green,
                                      child: Text('Page 1'),
                                    ),
                                    FlatButton(onPressed: () {print('Operating 02');}, child: Text('Test 2'),)
                                  ]),
                                ),
                              ),


                                

                              IgnorePointer(
                                ignoring: !animateNotifierPage2,
                                child: AnimatedOpacity(
                                  opacity: animateNotifierPage2 ? 1.0 : 0.0,
                                  duration: Duration(milliseconds: 250),
                                  child: Column( children: <Widget>[
                                                          Padding(
                                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                      child: Row(children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 2.0),
                                          child: Text(
                                            'By how much?'.toUpperCase(),
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
                                    Container(
                                      alignment: Alignment.center,
                                      color: Colors.green,
                                      child: Text('Page 2'),
                                    ),
                                  ]),
                                ),
                              ),





                              IgnorePointer(
                                ignoring: !animateNotifierPage3,
                                child: AnimatedOpacity(
                                  opacity: animateNotifierPage3 ? 1.0 : 0.0,
                                  duration: Duration(milliseconds: 250),
                                  child: Column( children: <Widget>[
                                                          Padding(
                                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                      child: Row(children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 2.0),
                                          child: Text(
                                            'Run this notifier...'.toUpperCase(),
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
                                    Container(
                                      alignment: Alignment.center,
                                      color: Colors.green,
                                      child: Text('Page 3'),
                                    ),
                                  ]),
                                ),
                              ),


                              



                            
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
                                padding: const EdgeInsets.fromLTRB(9.0, 0.0, 24.0, 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[

//-------------------------------------------------- Bottom Navigation

                                  AnimatedOpacity(
                                      opacity: animateBackButton ? 1.0 : 0.0,
                                      duration: Duration(milliseconds: 250),
                                      child: IconButton(
                                      onPressed: animateBackButton ? () {
                                        if(notifierNavigationData.pageCount > 0) {
                                          notifierNavigationData.pageCount -= 1;
                                        }
                                        if(notifierNavigationData.pageCount == 0) {
                                          setState(() {
                                            animateBackButton = false;
                                          });
                                        }
                                        if(notifierNavigationData.pageCount < 3) {
                                        setState(() {
                                          animateFinishButton = false;
                                        });

                                        notifierPageSet();

                                      }
                                      } : null,
                                      icon: Icon(Icons.arrow_back_ios, color: Colours.white13,),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if(notifierNavigationData.pageCount < 3) {
                                        notifierNavigationData.pageCount += 1;
                                      }
                                      if(notifierNavigationData.pageCount == 1) {
                                        setState(() {
                                          animateBackButton = true;
                                        });
                                      }
                                      if(notifierNavigationData.pageCount == 3) {
                                        setState(() {
                                          animateFinishButton = true;
                                        });
                                      }

                                      notifierPageSet();

                                    },
                                    child: Stack(
                                      alignment: Alignment.centerRight,
                                      children: <Widget>[

                                        AnimatedOpacity(
                                          opacity: animateFinishButton ? 0.0 : 1.0,
                                          duration: Duration(milliseconds: 150),
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

                                        AnimatedOpacity(
                                          opacity: animateFinishButton ? 1.0 : 0.0,
                                          duration: Duration(milliseconds: 150),
                                          child: Text(
                                            'Finish'.toUpperCase(),
                                            style: TextStyle(
                                              color: Colours.white13,
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ),
                                        


                                      ],
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
