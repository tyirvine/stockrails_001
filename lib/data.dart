

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
  
  int text = 0;
  factory NotifierNavigation() {
    return _notifierNavigationData;
  }
  NotifierNavigation._internal();
}

//Initialization for notifier navigation data
final notifierNavigationData = NotifierNavigation();