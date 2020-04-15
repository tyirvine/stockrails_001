
//Dependencies
import 'package:flutter/material.dart';

//Database table and column names
final String tableNotifiers = 'notifiers';

//Identification
final String columnId = '_id';
final String columnSymbol = 'symbol';
final String columnCompanyName = 'companyname';
final String columnExchange = 'exchange';

//Notifier
final String columnPage0Input = 'page0Input';
final String columnPage0Unit = 'page0Unit';
final String columnPage1Input = 'page1Input';
final String columnPage2Input = 'page2Input';
final String columnPage2Unit = 'page2Unit';
final String columnPage3Input = 'page3Input';

//Logic
final String columnPrinciplePrice = 'principlePrice';
final String columnPrincipleDate = 'principleDate';

//Column Array
final List<String> columnNames = [columnId, columnSymbol, columnCompanyName, columnExchange, columnPage0Input, columnPage0Unit, columnPage1Input, columnPage2Input, columnPage2Unit, columnPage3Input, columnPrinciplePrice, columnPrincipleDate];


/*........................................... Models ......................................*/


// * NotifierInstance : Contains bridge data (any temporary data on it's way to the database)
class NotifierInstance {
  // Identification
  int id;
  String symbol;
  String companyname;
  String exchange;

  // Notifier
  int page0Input;
  int page0Unit;
  List<String> page0UnitList = ['Hours', 'Days', 'Weeks', 'Months'];
  int page1Input;
  List<String> page1List = ['Gains', 'Losses', 'Both'];
  int page2Unit;
  var page2Input;
  List<String> page2UnitList = [r'$', r'%', 'PIP'];
  int page3Input;
  List<String> page3List = ['Forever', 'Once'];

  // Logic
  dynamic principlePrice;
  int principleDate;

  // NotifierInstance constructor
  NotifierInstance({
    // Identification
    this.id,
    @required this.symbol,
    @required this.companyname,
    @required this.exchange,

    // Notifier
    @required this.page0Input,
    @required this.page1Input,
    @required this.page0Unit,
    @required this.page2Input,
    @required this.page2Unit,
    @required this.page3Input,

    // Logic
    @required this.principleDate,
    @required this.principlePrice,
  });

  NotifierInstance.useGeneratedMap(List<Map<String, dynamic>> maps, int i) {
     NotifierInstance(
          id: maps[i][columnId],
          symbol: maps[i][columnSymbol],
          companyname: maps[i][columnCompanyName],
          exchange: maps[i][columnExchange],
          page0Input: maps[i][columnPage0Input],
          page0Unit: maps[i][columnPage0Unit],
          page1Input: maps[i][columnPage1Input],
          page2Input: maps[i][columnPage2Input],
          page2Unit: maps[i][columnPage2Unit],
          page3Input: maps[i][columnPage3Input],
          principlePrice: maps[i][columnPrinciplePrice],
          principleDate: maps[i][columnPrincipleDate],
    );
  }

  // .fromMap function for NotifierInstance
  NotifierInstance.fromMap(Map<String, dynamic> map) {
    //Identification
    id = map[columnId];
    symbol = map[columnSymbol];
    companyname = map[columnCompanyName];
    exchange = map[columnExchange];

    //Notifier
    page0Input = map[columnPage0Input];
    page0Unit = map[columnPage0Unit];
    page1Input = map[columnPage1Input];
    page2Input = map[columnPage2Input];
    page2Unit = map[columnPage2Unit];
    page3Input = map[columnPage3Input];

    //Logic
    principlePrice = map[columnPrinciplePrice];
    principleDate = map[columnPrincipleDate];
  }

  // Allows NotifierInstance to be converted to a map ~ defines .toMap()
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      /*Identification*/
      columnSymbol: symbol,
      columnCompanyName: companyname,
      columnExchange: exchange,

      /*Notifier*/
      columnPage0Input: page0Input,
      columnPage0Unit: page0Unit,
      columnPage1Input: page1Input,
      columnPage2Input: page2Input,
      columnPage2Unit: page2Unit,
      columnPage3Input: page3Input,

      /*Logic*/
      columnPrinciplePrice: principlePrice,
      columnPrincipleDate: principleDate,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  // Formats data output through an override of .toString()
  @override
  String toString() {
    return '''\n\n
        .
        Notifier{ id: $id,
        .
        // Identification
        symbol: $symbol,
        companyname: $companyname,
        exchange: $exchange,
        .
        // Notifier
        page 0: $page0Input ${page0UnitList[page0Unit]},
        page 1: ${page1List[page1Input]},
        page 2: ${page2UnitList[page2Unit]} $page2Input,
        page 3: ${page3List[page3Input]} }
        .
        // Logic
        principle price: $principlePrice,
        principle date: ${DateTime.fromMillisecondsSinceEpoch(principleDate)},
        .
      ''';
  }
}
