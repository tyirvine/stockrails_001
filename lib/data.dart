

/*........................................... Data ......................................*/


// * Navigation Data : for the notifier creation menu
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

// Initialization for notifier navigation data
final notifierNavigationData = NotifierNavigation();

// * Notifier Data : contains important notifier creation data
class NotifierData {
  // Turns class into singleton
  static final NotifierData _notifierData = new NotifierData._internal();

  //UI Data
  bool notifierHasAlert = false;

  //First Page Data
  int notifierPage0NumberData = 0;
  int notifierPage0UnitData = 0;
  List<String> notifierPage0UnitList = ['Hours', 'Days', 'Weeks', 'Months'];

  //Second Page Data
  int notifierPage1Data = 0;
  List<String> notifierPage1List = ['Gains', 'Losses', 'Both'];

  //Third Page Data
  int notifierPage2UnitData = 0;
  var notifierPage2InputData = 0.0;
  List<String> notifierPage2UnitList = [r'$', r'%', 'PIP'];

  //Fourth Page Data
  int notifierPage3Data = 0;
  List<String> notifierPage3List = ['Forever', 'Once'];

  //Logic Data
  dynamic notifierPrinciplePrice = 0.0;
  int notifierPrincipleDate = 0; // year / month / day / hour / minute / second

  // Resets all data pretaining to notifier
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
    notifierPrincipleDate = 0;
  }

  // Required for singleton class
  factory NotifierData() {
    return _notifierData;
  }
  NotifierData._internal();
}

// Initialization for NotifierData
final notifierData = NotifierData();
