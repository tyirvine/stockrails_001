

//Flutter SDK
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Global Data
import 'package:stockrails_001/data.dart';
import 'package:stockrails_001/storage/saves.dart';

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
  NotifierDatabaseHelper database;
  NotifierData notifier;


  //Notifier Animations
  bool animateBackButton = false;
  bool animateFinishButton = false;
  bool animateNotifierPage0 = true;
  bool animateNotifierPage1 = false;
  bool animateNotifierPage2 = false;
  bool animateNotifierPage3 = false;
  _NotifierState({this.navigation});

  //Notifier Text Input Controller
  final notifierPage2Controller = TextEditingController();


  //Symbol data from search.dart
  Map data = {};
  



  @override
  Widget build(BuildContext context) {
    
    //Symbol data from search.dart
    data = ModalRoute.of(context).settings.arguments;

    //Notifier Page 0 Text Widget
    notifierPage0Widget(int number) {
      return Center(child: Text('$number'));
    }

    //Notifier page setter
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


    return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
             }

          },
          child: Scaffold(
            resizeToAvoidBottomInset : false,
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

//-------------------------------------------------- Navigation & Notifier Reset On Close !

                                    IconButton(onPressed: () {

                                      Navigator.pop(context);
                                      notifierData.notifierDataReset();
                                      notifierNavigationData.pageCountReset();
                                      setState(() {
                                        animateNotifierPage0 = true;
                                        animateNotifierPage1 = false;
                                        animateNotifierPage2 = false;
                                        animateNotifierPage3 = false;
                                        });
                                      },

                                      icon: Icon(Icons.close),
                                      color: Colors.white),
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
                                
//-------------------------------------------------- Notifier Page 0 !

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
                                                    onSelectedItemChanged: (int i) {setState(() {
                                                      notifierData.notifierPage0NumberData = i + 1;
                                                    });},
                                                    children: <Widget> [
                                                      notifierPage0Widget(1),
                                                      notifierPage0Widget(2),
                                                      notifierPage0Widget(3),
                                                      notifierPage0Widget(4),
                                                      notifierPage0Widget(5),
                                                      notifierPage0Widget(6),
                                                      notifierPage0Widget(7),
                                                      notifierPage0Widget(8),
                                                      notifierPage0Widget(9),
                                                      notifierPage0Widget(10),
                                                      notifierPage0Widget(11),
                                                      notifierPage0Widget(12),
                                                      notifierPage0Widget(13),
                                                      notifierPage0Widget(14),
                                                      notifierPage0Widget(15),
                                                      notifierPage0Widget(16),
                                                      notifierPage0Widget(17),
                                                      notifierPage0Widget(18),
                                                      notifierPage0Widget(19),
                                                      notifierPage0Widget(20),
                                                      notifierPage0Widget(21),
                                                      notifierPage0Widget(22),
                                                      notifierPage0Widget(23),
                                                      notifierPage0Widget(24),
                                                      notifierPage0Widget(25),
                                                      notifierPage0Widget(26),
                                                      notifierPage0Widget(27),
                                                      notifierPage0Widget(28),
                                                      notifierPage0Widget(29),
                                                      notifierPage0Widget(30),
                                                      notifierPage0Widget(31),
                                                      notifierPage0Widget(32),
                                                      notifierPage0Widget(33),
                                                      notifierPage0Widget(34),
                                                      notifierPage0Widget(35),
                                                      notifierPage0Widget(36),
                                                      notifierPage0Widget(37),
                                                      notifierPage0Widget(38),
                                                      notifierPage0Widget(39),
                                                      notifierPage0Widget(40),
                                                      notifierPage0Widget(41),
                                                      notifierPage0Widget(42),
                                                      notifierPage0Widget(43),
                                                      notifierPage0Widget(44),
                                                      notifierPage0Widget(45),
                                                      notifierPage0Widget(46),
                                                      notifierPage0Widget(47),
                                                      notifierPage0Widget(48),
                                                      notifierPage0Widget(49),
                                                      notifierPage0Widget(50),
                                                      notifierPage0Widget(51),
                                                      notifierPage0Widget(52),
                                                      notifierPage0Widget(53),
                                                      notifierPage0Widget(54),
                                                      notifierPage0Widget(55),
                                                      notifierPage0Widget(56),
                                                      notifierPage0Widget(57),
                                                      notifierPage0Widget(58),
                                                      notifierPage0Widget(59),
                                                      notifierPage0Widget(60),
                                                      notifierPage0Widget(61),
                                                      notifierPage0Widget(62),
                                                      notifierPage0Widget(63),
                                                      notifierPage0Widget(64),
                                                      notifierPage0Widget(65),
                                                      notifierPage0Widget(66),
                                                      notifierPage0Widget(67),
                                                      notifierPage0Widget(68),
                                                      notifierPage0Widget(69),
                                                      notifierPage0Widget(70),
                                                      notifierPage0Widget(71),
                                                      notifierPage0Widget(72),
                                                      notifierPage0Widget(73),
                                                      notifierPage0Widget(74),
                                                      notifierPage0Widget(75),
                                                      notifierPage0Widget(76),
                                                      notifierPage0Widget(77),
                                                      notifierPage0Widget(78),
                                                      notifierPage0Widget(79),
                                                      notifierPage0Widget(80),
                                                      notifierPage0Widget(81),
                                                      notifierPage0Widget(82),
                                                      notifierPage0Widget(83),
                                                      notifierPage0Widget(84),
                                                      notifierPage0Widget(85),
                                                      notifierPage0Widget(86),
                                                      notifierPage0Widget(87),
                                                      notifierPage0Widget(88),
                                                      notifierPage0Widget(89),
                                                      notifierPage0Widget(90),
                                                      notifierPage0Widget(91),
                                                      notifierPage0Widget(92),
                                                      notifierPage0Widget(93),
                                                      notifierPage0Widget(94),
                                                      notifierPage0Widget(95),
                                                      notifierPage0Widget(96),
                                                      notifierPage0Widget(97),
                                                      notifierPage0Widget(98),
                                                      notifierPage0Widget(99),
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
                                                      onSelectedItemChanged: (int i) {setState(() {
                                                        notifierData.notifierPage0UnitData = i;
                                                      });},
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
                                        ),

                                        SizedBox(height: 10.0),

                                        Text('Selected: ' + notifierData.notifierPage0NumberData.toString() + ' ' + notifierData.notifierPage0UnitList[notifierData.notifierPage0UnitData], style: TextStyle(color: Colours.white13)),



                                      ]),
                                    ),
                                  ),
                                ),


//-------------------------------------------------- Notifier Page 1 !

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

                                      SizedBox(height: 20.0),

                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: FlatButton(
                                          onPressed: () {setState(() {
                                            notifierData.notifierPage1Data = 0;
                                          });},
                                          padding: EdgeInsets.all(20.0),
                                          color: Colours.blue3,
                                          child: Text(
                                            'Gains',
                                            style: TextStyle(
                                              color: Colours.white13,
                                              fontSize: 30.0,
                                            ),
                                          )
                                          ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: FlatButton(
                                          onPressed: () {setState(() {
                                            notifierData.notifierPage1Data = 1;
                                          });},
                                          padding: EdgeInsets.all(20.0),
                                          color: Colours.blue3,
                                          child: Text(
                                            'Losses',
                                            style: TextStyle(
                                              color: Colours.white13,
                                              fontSize: 30.0,
                                            ),
                                          )
                                          ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: FlatButton(
                                          onPressed: () {setState(() {
                                            notifierData.notifierPage1Data = 2;
                                          });},
                                          padding: EdgeInsets.all(20.0),
                                          color: Colours.blue3,
                                          child: Text(
                                            'Both',
                                            style: TextStyle(
                                              color: Colours.white13,
                                              fontSize: 30.0,
                                            ),
                                          )
                                          ),
                                      ),

                                      SizedBox(height: 10.0),

                                      Text('Selected: ' + notifierData.notifierPage1List[notifierData.notifierPage1Data], style: TextStyle(color: Colours.white13)),


                                    ]),
                                  ),
                                ),


//-------------------------------------------------- Notifier Page 2 ! 

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

                                      //Unit Selector                                
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                                              height: 305.0,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  
                                                  Container(
                                                    alignment: Alignment.center,
                                                    height: 275.0,
                                                    width: 75.0,
                                                    child: CupertinoTheme(
                                                      data: CupertinoThemeData(
                                                        textTheme: CupertinoTextThemeData(
                                                          //Styling
                                                          pickerTextStyle: TextStyle(
                                                            color: Colours.white13,
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 30.0
                                                          )
                                                        )
                                                      ),
                                                      child: my.CupertinoPicker(
                                                        backgroundColor: Color(0xFF5b8aea),
                                                        magnification: 0.9,
                                                        diameterRatio: 3.0,
                                                        itemExtent: 75.0,
                                                        onSelectedItemChanged: (int i) {setState(() {
                                                          notifierData.notifierPage2UnitData = i;
                                                        });},
                                                        children: <Widget> [
                                                          Center(child: Text(r'$')),
                                                          Center(child: Text(r'%')),
                                                          Center(child: Text(r'PIP')),
                                                      ],),
                                                    ),
                                                  ),

                                                  Container(
                                                    height: 60.0,
                                                    child: VerticalDivider(color: Colours.blue4),
                                                    ),

                                                ],
                                              ),
                                            ),
                                          

                                      Container(
                                        padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                                        width: 200.0,
                                        child: TextField(
                                          controller: notifierPage2Controller,
                                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                                          cursorColor: Colors.grey[100],
                                          decoration: InputDecoration(
                                            hintText: 'Input',
                                            hintStyle: TextStyle(
                                              color: Colors.white10,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          style: TextStyle(
                                            fontSize: 40.0,
                                            color: Colours.white13,
                                            ),
                                          ),
                                      ),
                                        
                                        ],
                                      ),


                                      SizedBox(height: 10.0),

                                      Text('Selected: ' + notifierData.notifierPage2UnitList[notifierData.notifierPage2UnitData] + ' ' + notifierPage2Controller.text.toString(), style: TextStyle(color: Colours.white13)),






                                    ]),
                                  ),
                                ),



//-------------------------------------------------- Notifier Page 3 !

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
                                      
                                      
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: FlatButton(
                                          onPressed: () {setState(() {
                                            notifierData.notifierPage3Data = 0;
                                          });},
                                          padding: EdgeInsets.all(20.0),
                                          color: Colours.blue3,
                                          child: Text(
                                            'Forever',
                                            style: TextStyle(
                                              color: Colours.white13,
                                              fontSize: 30.0,
                                            ),
                                          )
                                          ),
                                      ),


                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: FlatButton(
                                          onPressed: () {setState(() {
                                            notifierData.notifierPage3Data = 1;
                                          });},
                                          padding: EdgeInsets.all(20.0),
                                          color: Colours.blue3,
                                          child: Text(
                                            'Once',
                                            style: TextStyle(
                                              color: Colours.white13,
                                              fontSize: 30.0,
                                            ),
                                          )
                                          ),
                                      ),

                                      SizedBox(height: 10.0),

                                      RaisedButton(onPressed: () {
                                        notifierData.notifierPrincipleDate = DateTime.now().millisecondsSinceEpoch;
                                        notifierData.notifierPage2InputData = double.parse(notifierPage2Controller.text);
                                        
                                        notifierHelperData.write(
                                        NotifierInstance(

                                          //Identification
                                          symbol: '${data['symbol']}',
                                          companyname: '${data['companyname']}',
                                          exchange: '${data['exchange']}',

                                          //Notifier
                                          page0Input: notifierData.notifierPage0NumberData,
                                          page0Unit: notifierData.notifierPage0UnitData,
                                          page1Input: notifierData.notifierPage1Data,
                                          page2Input: notifierData.notifierPage2InputData,
                                          page2Unit: notifierData.notifierPage2UnitData,
                                          page3Input: notifierData.notifierPage3Data,

                                          //Logic
                                          principlePrice: notifierData.notifierPrinciplePrice,
                                          principleDate: notifierData.notifierPrincipleDate,

                                      ));},
                                      child: Text('Write')
                                      ),

                                      RaisedButton(onPressed: () {notifierHelperData.readAll();}, child: Text('Read')),

                                      SizedBox(height: 10.0),

                                      Text('Selected: ' + notifierData.notifierPage3List[notifierData.notifierPage3Data], style: TextStyle(color: Colours.white13)),


                                      
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
                                            if(notifierNavigationData.pageCount == 4) notifierNavigationData.pageCount -= 2;
                                            else notifierNavigationData.pageCount -= 1;
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

                                          //This ensures the pages get refreshed
                                          notifierPageSet();

                                        }
                                        } : null,
                                        icon: Icon(Icons.arrow_back_ios, color: Colours.white13,),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if(notifierNavigationData.pageCount < 4) {
                                          notifierNavigationData.pageCount += 1;
                                          print(notifierNavigationData.pageCount.toString());
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

                                        //This ensures the pages get refreshed
                                        notifierPageSet();

//-------------------------------------------------- Notifier Creation Finish !

                                        if(notifierNavigationData.pageCount == 4) {
                                        }

                                        

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
      ),
    );
  }
}



/*........................................... Program ......................................*/
