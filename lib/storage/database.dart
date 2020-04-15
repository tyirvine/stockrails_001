
//Dart files
import 'dart:async';

//Dependencies
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//Models
import 'package:stockrails_001/models/notifier-model.dart';

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


/*........................................... Storage ......................................*/


// * DatabaseHelper : This class runs the SQLite database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "notifier_database.db";

  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Singleton Class Constructor
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper _databaseHelper = DatabaseHelper._privateConstructor();

  factory DatabaseHelper () {
    return _databaseHelper;
  }

  // Allows One Connection
  static Database _database;

  // Is used to connect to the database
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // Establishes The Database
  _initDatabase() async {
    // This grabs the path for the database
    String documentsDirectory = await getDatabasesPath();

    // And then joins it with the database itself
    String path = join(documentsDirectory, _databaseName);

    // Connects to the database and creates a SQL table
    return await openDatabase(path, version: _databaseVersion, onCreate: (db, version) async {
      await db.execute(
        "CREATE TABLE $tableNotifiers($columnId INTEGER PRIMARY KEY, $columnSymbol TEXT, $columnCompanyName TEXT, $columnExchange TEXT, $columnPage0Input INTEGER, $columnPage0Unit INTEGER, $columnPage1Input INTEGER, $columnPage2Input REAL, $columnPage2Unit INTEGER, $columnPage3Input INTEGER, $columnPrinciplePrice REAL, $columnPrincipleDate BLOB)",
      );
    });
  }

/* ................................. Database Helper Methods .............................. */

  //Inserts A Notifier
  insert(NotifierInstance notifier) async {
    Database db = await database;
    int id = await db.insert(tableNotifiers, notifier.toMap());
    return id;
  }

  //Returns All Notifiers
  queryAllNotifiers() async {
    final Database db = await database; //Database connection
    final List<Map<String, dynamic>> maps = await db.query(tableNotifiers); //Notifier map

    //This will return all entities if the database is filled
    if (maps.length > 0) {
      return List.generate(maps.length, (i) {
        return NotifierInstance.useGeneratedMap(maps, i);
      });
    }
    //This will return null if the database is empty
    return null;
  }
  
  //Returns All Symbols Without Duplicates
  queryAllSymbols() async {
    final Database db = await database; //Database connection
    final List<Map<String, dynamic>> maps = await db.query(
      tableNotifiers,
      columns: columnNames,
      groupBy: columnSymbol,
    ); //Notifier map
    //This will return all entities if the database is filled
    if (maps.length > 0) {
      return List.generate(maps.length, (i) {
        return NotifierInstance.useGeneratedMap(maps, i);
      });
    }
    //This will return null if the database is empty
    return null;
  }

  //Returns Total Symbol Count
  queryTotalSymbolCount() async {
    final Database db = await database; //Database connection
    final List<Map<String, dynamic>> maps = await db.query(
      tableNotifiers,
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
  querySymbolCount(String symbol) async {
    final Database db = await database; //Database connection
    final List<Map<String, dynamic>> maps = await db.query(
      tableNotifiers,
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
  queryNotifier(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(
      tableNotifiers,
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
  queryNotifierFromSymbol(String symbol) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      tableNotifiers,
      columns: columnNames,
      where: '$columnSymbol = ?',
      whereArgs: [symbol],
    );
    if (maps.length > 0) {
      return List.generate(maps.length, (i) {
        return NotifierInstance.useGeneratedMap(maps, i);
      });
    }
    return null;
  }

  //Deletes Specified Notifier
  deleteNotifier(int id) async {
    Database db = await database;
    return await db.delete(tableNotifiers, where: '$columnId = ?', whereArgs: [id]);
  }

  //Updates Specified Notifier
  updateNotifier(NotifierInstance notifier) async {
    Database db = await database;
    return await db.update(tableNotifiers, notifier.toMap(), where: '$columnId = ?', whereArgs: [notifier.id]);
  }
}

// Takes the return from the DatabaseHelper factory and places it in this object to be used globally
final databaseHelper = DatabaseHelper();

