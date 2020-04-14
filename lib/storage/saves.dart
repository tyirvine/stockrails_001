
//Dependencies
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

//Dart files
import 'dart:async';



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


//-------------------------------------------------- Notifier Data Class

class NotifierInstance {

    //Identification
    int id;
    String symbol;
    String companyname;
    String exchange;

    //Notifier
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

    //Logic
    dynamic principlePrice;
    int principleDate;

    //Constructor
    NotifierInstance({
      //Identification
      this.id,
      @required this.symbol,
      @required this.companyname,
      @required this.exchange,

      //Notifier
      @required this.page0Input,
      @required this.page1Input,
      @required this.page0Unit,
      @required this.page2Input,
      @required this.page2Unit,
      @required this.page3Input,

      //Logic
      @required this.principleDate,
      @required this.principlePrice,
      });


    NotifierInstance.fromMap(Map<String, dynamic> map) {

      //Identification
      id = map[columnId];
      symbol = map[columnSymbol];
      companyname = map[columnCompanyName];
      exchange = map [columnExchange];

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


//-------------------------------------------------- Overrides for strings !

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







/*........................................... Program ......................................*/




    class DatabaseHelper {

      // This is the actual database filename that is saved in the docs directory.
      static final _databaseName = "notifier_database.db";

      // Increment this version when you need to change the schema.
      static final _databaseVersion = 1;

      //Singleton Class Constructor
      DatabaseHelper._privateConstructor();
      static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

      //Allows One Connection
      static Database _database;
      Future<Database> get database async {
        if (_database != null) return _database;
        _database = await _initDatabase();
        return _database;
      }

      //Opens The Database
      _initDatabase() async {
        // The path_provider plugin gets the right directory for Android or iOS.
        String documentsDirectory = await getDatabasesPath();
        String path = join(documentsDirectory, _databaseName);
        // Open the database. Can also add an onUpdate callback parameter.
        return await openDatabase(path,
            version: _databaseVersion,
            onCreate: (db, version) async { await db.execute(
          "CREATE TABLE $tableNotifiers($columnId INTEGER PRIMARY KEY, $columnSymbol TEXT, $columnCompanyName TEXT, $columnExchange TEXT, $columnPage0Input INTEGER, $columnPage0Unit INTEGER, $columnPage1Input INTEGER, $columnPage2Input REAL, $columnPage2Unit INTEGER, $columnPage3Input INTEGER, $columnPrinciplePrice REAL, $columnPrincipleDate BLOB)",
          );
             }
          );
      }



// * -------------------------------------------------- Database Helper Methods

      //Inserts A Notifier
      Future<int> insert(NotifierInstance notifier) async {
        Database db = await database;
        int id = await db.insert(tableNotifiers, notifier.toMap());
        return id;
      }


      //Returns All Notifiers
      Future<List<NotifierInstance>> queryAllNotifiers() async {

        final Database db = await database; //Database connection
        final List<Map<String, dynamic>> maps = await db.query(tableNotifiers); //Notifier map

        //This will return all entities if the database is filled
        if (maps.length > 0) {
          return List.generate(maps.length, (i) {
            return NotifierInstance(
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
          });
        }
        //This will return null if the database is empty
        return null;
      }


      //Returns All Symbols Without Duplicates
      Future<List<NotifierInstance>> queryAllSymbols() async {
        final Database db = await database; //Database connection
        final List<Map<String, dynamic>> maps = await db.query(tableNotifiers,
        columns: columnNames,
        groupBy: columnSymbol,
        ); //Notifier map

        //This will return all entities if the database is filled
        if (maps.length > 0) {
          return List.generate(maps.length, (i) {
            return NotifierInstance(
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
          });
        }
        //This will return null if the database is empty
        return null;
      }



      //Returns Total Symbol Count
      Future<int> queryTotalSymbolCount() async {
        final Database db = await database; //Database connection
        final List<Map<String, dynamic>> maps = await db.query(tableNotifiers,
          columns: [columnSymbol],
        ); //Notifier map

        //This will return all entities if the database is filled
        if (maps.length > 0) {
          return await Future.value(maps.length);
        }
        //This will return null if the database is empty
        return null;
      }


      //Returns Notifier Count of Specified Sybmbol
      Future<int> querySymbolCount(String symbol) async {
        final Database db = await database; //Database connection
        final List<Map<String, dynamic>> maps = await db.query(tableNotifiers,
          columns: columnNames,
          where: '$columnSymbol = ?',
          whereArgs: [symbol],
        ); //Notifier map

        //This will return all entities if the database is filled
        if (maps.length > 0) {
          return maps.length;
        }
        //This will return null if the database is empty
        return null;
      }


      //Returns One Notifier
      Future<NotifierInstance> queryNotifier(int id) async {
        Database db = await database;
        List<Map> maps = await db.query(tableNotifiers,
            columns: columnNames,
            where: '$columnId = ?',
            whereArgs: [id],
        );
        //This will return an entity if the database is filled
        if (maps.length > 0) {
          return NotifierInstance.fromMap(maps.first);
        }
        //This will return null if there are no items in the database
        return null;
      }


      //Returns Notifier List Based On Symbol
      Future<List> queryNotifierFromSymbol(String symbol) async {
        Database db = await database;
        List<Map<String, dynamic>> maps = await db.query(tableNotifiers,
        columns: columnNames,
        where: '$columnSymbol = ?',
        whereArgs: [symbol],
        );
        if(maps.length > 0) {
          return List.generate(maps.length, (i) {
            return NotifierInstance(
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
          });
        }
        return null;
      }


      //Deletes Specified Notifier
      Future<int> deleteNotifier(int id) async {
        Database db = await database;
        return await db.delete(tableNotifiers, where: '$columnId = ?', whereArgs: [id]);
      }


      //Updates Specified Notifier
      Future<int> updateNotifier(NotifierInstance notifier) async {
        Database db = await database;
        return await db.update(tableNotifiers, notifier.toMap(), where: '$columnId = ?', whereArgs: [notifier.id]);
      }


} //DatabaseHelper End






class NotifierDatabaseHelper {
  
  static final NotifierDatabaseHelper _notifierHelperData = new NotifierDatabaseHelper._internal();
  
/* Data goes below ⤵ -----------------------------------------------------> */

  Future refresh;

  //Reads A Notifier
  read(int id) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    NotifierInstance notifier = await helper.queryNotifier(id);
    if (notifier == null) {
     print('Read: Notifier is null');
    }
    else {
     debugPrint(notifier.toString());
    }
  }


  //Reads Entire Database
  readAll() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    List<NotifierInstance> notifier = await helper.queryAllNotifiers();
    if (notifier == null) {
     print('Read All: Database is null');
    }
    else {
      debugPrint(notifier.toString());
      return notifier;
    }
  }


  //Reads A Symbol's Notifiers
  readSymbol(String symbol) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    List notifier = await helper.queryNotifierFromSymbol(symbol);
    if (notifier == null) {
      print('Read Symbol: Database is null');
    }
    else {
      debugPrint(notifier.toString());
    }
  }


  // Reads All Symbols
  readAllSymbols() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    List symbols = await helper.queryAllSymbols();
    if (symbols == null) {
      print('Read All Symbols: Database is null');
    }
    else {
      return symbols;
    }
  }


  // Reads Symbol Count of Specified Symbol
  readSymbolCount(String symbol) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int symbolCountList = await helper.querySymbolCount(symbol);
    final int symbols = symbolCountList;
    if (symbols == null) {
      print('Read Symbol Count: Database is null');
    }
    else {
      return symbols;
    }
  }


  // Reads Total Symbol Count
  readTotalSymbolCount() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int symbols = await helper.queryTotalSymbolCount();
    if (symbols == null) {
      print('Read Symbol Count: Database is null');
    }
    else {
      return symbols.toInt();
    }
  }


  //Inserts A Notifier
  write(NotifierInstance notifier) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.insert(notifier);
    print('Inserted into row: $id');
  }


  //Delete Notifier
  delete(int id) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    await helper.deleteNotifier(id);
    print('Notifier $id was deleted');
  }


  //Update Notifier
  update(NotifierInstance notifier) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    await helper.updateNotifier(notifier);
    print('Notifier ${notifier.id} has been updated');
  }




/* Data ⤴ ----------------------------------------------------------------> */
  
  factory NotifierDatabaseHelper() {
    return _notifierHelperData;
  }
  NotifierDatabaseHelper._internal();
}

//The object that holds the data
final notifierHelperData = NotifierDatabaseHelper();






/*........................................... Program ......................................*/