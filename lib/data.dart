

//Flutter SDK
import 'package:flutter/material.dart';


/*........................................... Program ......................................*/



//Colours : for the entire project
class Colours {

static const blue1 = const Color(0xFF517CD3);
static const blue2 = const Color(0xFF5B8AEA);
static const blue3 = const Color(0xFF6292F3);
static const blue4 = const Color(0xFF7BA7FF);
static const blue5 = const Color(0xFFC5D8FF);
static const green6 = const Color(0xFF89B78A);
static const grey7 = const Color(0xFF373B49);
static const grey8 = const Color(0xFF454A5C);
static const grey9 = const Color(0xFF3E4251);
static const grey10 = const Color(0xFF656C84);
static const grey11 = const Color(0xFF6C748F);
static const grey12 = const Color(0xFFD0D0D0);
static const white13 = const Color(0xFFFFFFFF);
static const red14 = const Color(0xFFC95C5C);

}



//Navigation Data : for the notifier creation menu
class NotifierNavigation {

  static final NotifierNavigation _notifierNavigationData = new NotifierNavigation._internal();
  
  int pageCount = 0;

  pageCountReset() {
    pageCount = 0;
  }

  factory NotifierNavigation() {
    return _notifierNavigationData;
  }
  NotifierNavigation._internal();
}

//Initialization for notifier navigation data
final notifierNavigationData = NotifierNavigation();




class NotifierData {

  static final NotifierData _notifierData = new NotifierData._internal();

  //First Page Data
  int notifierPage0NumberData = 0;
  int notifierPage0UnitData = 0;
  List<String> notifierPage0UnitList = ['Hours', 'Days', 'Weeks', 'Months'];

  //Second Page Data
  int notifierPage1Data = 0;
  List<String> notifierPage1List = ['Gains', 'Losses', 'Both'];

  //Third Page Data
  int notifierPage2UnitData = 0;
  int notifierPage2InputData = 0;
  List<String> notifierPage2UnitList = [r'$', r'%', 'PIP'];

  //Fourth Page Data
  int notifierPage3Data = 0;
  List<String> notifierPage3List = ['Forever', 'Once'];

  //Logic Data
  var notifierPrinciplePrice = 0.0;
  DateTime notifierPrincipleDate = DateTime(2020, 1, 1, 0, 0, 0); // year / month / day / hour / minute / second


  notifierDataReset() {
    //First Page Data
    notifierPage0NumberData = 0;
    notifierPage0UnitData = 0;

    //Second Page Data
    notifierPage1Data = 0;

    //Third Page Data
    notifierPage2UnitData = 0;
    notifierPage2InputData = 0;

    //Fourth Page Data
    notifierPage3Data = 0;

    //Principle Price
    notifierPrinciplePrice = 0.0;
    notifierPrincipleDate = DateTime(2020, 1, 1, 0, 0, 0);    
  }


  factory NotifierData() {
    return _notifierData;
  }
  NotifierData._internal();
}

//Initialization for notifier navigation data
final notifierData = NotifierData();