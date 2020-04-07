
//Dependencies
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

//Dart files
import 'dart:async';
import 'dart:io';



//Database table and column names
final String tableNotifiers = 'notifiers';
final String columnId = '_id';
final String columnPage0NumberData = 'page0NumberData';
final String columnPage0UnitData = 'page0UnitData';
final String columnPage1Data = 'page1Data';
final String columnPage2UnitData = 'page2UnitData';
final String columnPage2InputData = 'page2InputData';
final String columnPage3Data = 'page3Data';

//Notifier data class
class Notifier {

    //Identification
    int id;

    //First Page Data
    int page0NumberData;
    int page0UnitData;

    //Second Page Data
    int page1Data;

    //Third Page Data
    int page2UnitData;
    int page2InputData;

    //Fourth Page Data
    int page3Data;

    Notifier({this.id, this.page0NumberData, this.page0UnitData, this.page1Data, this.page2InputData, this.page2UnitData, this.page3Data});

    Notifier.fromMap(Map<String, dynamic> map) {
      id = map[columnId];
      page0NumberData = map[columnPage0NumberData];
      page0UnitData = map[columnPage0UnitData];
      page1Data = map[columnPage1Data];
      page2InputData = map[columnPage2InputData];
      page2UnitData = map[columnPage2UnitData];
      page3Data = map[columnPage3Data];
    }

    Map<String, dynamic> toMap() {
      var map = <String, dynamic>{
        columnPage0NumberData: page0NumberData,
        columnPage0UnitData: page0UnitData,
        columnPage1Data: page1Data,
        columnPage2InputData: page2InputData,
        columnPage2UnitData: page2UnitData,
        columnPage3Data: page3Data,
      };
      if (id != null) {
        map[columnId] = id;
      }
      return map;
    }
}



  //Singleton class to manage the database
    class DatabaseHelper {

    // final Future<Database> database = openDatabase(

    //   join(await getDatabasesPath(), 'database.db'),

    // );



      // This is the actual database filename that is saved in the docs directory.
      static final _databaseName = "notifier_database.db";
      // Increment this version when you need to change the schema.
      static final _databaseVersion = 1;

      // Make this a singleton class.
      DatabaseHelper._privateConstructor();
      static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

      // Only allow a single open connection to the database.
      static Database _database;
      Future<Database> get database async {
        if (_database != null) return _database;
        _database = await _initDatabase();
        return _database;
      }

      // open the database
      _initDatabase() async {
        // The path_provider plugin gets the right directory for Android or iOS.
        Directory documentsDirectory = await getApplicationDocumentsDirectory();
        String path = join(documentsDirectory.path, _databaseName);
        // Open the database. Can also add an onUpdate callback parameter.
        return await openDatabase(path,
            version: _databaseVersion,
            onCreate: (db, version) async { await db.execute(
          "CREATE TABLE $tableNotifiers($columnId INTEGER PRIMARY KEY, $columnPage0NumberData INTEGER, $columnPage0UnitData INTEGER, $columnPage1Data INTEGER, $columnPage2InputData INTEGER, $columnPage2UnitData INTEGER, $columnPage3Data INTEGER)",
          );
             }
          );
      }

      // // SQL string to create the database 
      // Future _onCreate(Database db, int version) async {
      //   await 
      // }

      // Database helper methods:

      Future<int> insert(Notifier notifier) async {
        Database db = await database;
        int id = await db.insert(tableNotifiers, notifier.toMap());
        return id;
      }


//-------------------------------------------------- Queries all notifiers in database !

      Future<List<Notifier>> queryAllNotifiers() async {
        Database db = await database;
        List<Map> maps = await db.query(tableNotifiers);

        //This will return all entities if the database is filled
        if (maps.length > 0) {
          return List.generate(maps.length, (i) {
            return Notifier(
              id: maps[i][columnId],
              page0NumberData: maps[i][columnPage0NumberData],
              page0UnitData: maps[i][columnPage0UnitData],
              page1Data: maps[i][columnPage1Data],
              page2InputData: maps[i][columnPage2InputData],
              page2UnitData: maps[i][columnPage2UnitData],
              page3Data: maps[i][columnPage3Data],
            );
          });
        }

        //This will return null if the database is empty
        return null;
      }



//-------------------------------------------------- Queries one notifier !

      Future<Notifier> queryNotifier(int id) async {
        Database db = await database;
        List<Map> maps = await db.query(tableNotifiers,
            columns: [columnId, columnPage0NumberData, columnPage0UnitData, columnPage1Data, columnPage2InputData, columnPage2UnitData, columnPage3Data],
            where: '$columnId = ?',
            whereArgs: [id],
        );

        //This will return an entity if the database is filled
        if (maps.length > 0) {
          return Notifier.fromMap(maps.first);
        }

        //This will return null if there are no items in the database
        return null;
      }

    }




//Carrier for the read() and save() methods
class NotifierDatabaseHelper {
  
  static final NotifierDatabaseHelper _notifierHelperData = new NotifierDatabaseHelper._internal();
  
/* Data goes below ⤵ -----------------------------------------------------> */

  read() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int rowId = 1;
    Notifier notifier = await helper.queryNotifier(rowId);
       if (notifier == null) {
     print('read row $rowId: empty');
   } else {
     print('read row $rowId: ${notifier.id} ${notifier.page0NumberData}');
   }
    print(notifier.toString());
  }

/* Data ⤴ ----------------------------------------------------------------> */
  
  factory NotifierDatabaseHelper() {
    return _notifierHelperData;
  }
  NotifierDatabaseHelper._internal();
}

//The object that holds the data
final notifierHelperData = NotifierDatabaseHelper();