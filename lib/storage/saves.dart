
//Dependencies
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//Dart files
import 'dart:async';


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
    List<String> page0UnitList = ['Hours', 'Days', 'Weeks', 'Months'];

    //Second Page Data
    int page1Data;
    List<String> page1List = ['Gains', 'Losses', 'Both'];

    //Third Page Data
    int page2UnitData;
    int page2InputData;
    List<String> page2UnitList = [r'$', r'%', 'PIP'];


    //Fourth Page Data
    int page3Data;
    List<String> page3List = ['Forever', 'Once'];


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


//-------------------------------------------------- Overrides for strings !

    @override
    String toString() {
      return '\n\n Notifier{  id: $id,  PAGE-0: $page0NumberData ${page0UnitList[page0UnitData]},  PAGE-1: ${page1List[page1Data]},  PAGE-2: ${page2UnitList[page2InputData]} $page2InputData,  PAGE-3: ${page3List[page3Data]} }\n\n';
    }
    
}






//-------------------------------------------------- Main Database !

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
          "CREATE TABLE $tableNotifiers($columnId INTEGER PRIMARY KEY, $columnPage0NumberData INTEGER, $columnPage0UnitData INTEGER, $columnPage1Data INTEGER, $columnPage2InputData INTEGER, $columnPage2UnitData INTEGER, $columnPage3Data INTEGER)",
          );
             }
          );
      }



//-------------------------------------------------- Database Helper Methods

      //Inserts A Notifier
      Future<int> insert(Notifier notifier) async {
        Database db = await database;
        int id = await db.insert(tableNotifiers, notifier.toMap());
        return id;
      }


      //Returns All Notifiers
      Future<List<Notifier>> queryAllNotifiers() async {

        final Database db = await database; //Database connection
        final List<Map<String, dynamic>> maps = await db.query(tableNotifiers); //Notifier map

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


      //Returns One Notifier
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


      //Deletes Specified Notifier
      Future<int> deleteNotifier(int id) async {
        Database db = await database;
        return await db.delete(tableNotifiers, where: '$columnId = ?', whereArgs: [id]);
      }


      //Updates Specified Notifier
      Future<int> updateNotifier(Notifier notifier) async {
        Database db = await database;
        return await db.update(tableNotifiers, notifier.toMap(), where: '$columnId = ?', whereArgs: [notifier.id]);
      }



} //DatabaseHelper End







//-------------------------------------------------- Carrier for the read() and save() methods !

class NotifierDatabaseHelper {
  
  static final NotifierDatabaseHelper _notifierHelperData = new NotifierDatabaseHelper._internal();
  
/* Data goes below ⤵ -----------------------------------------------------> */


  //Reads A Notifier
  read(int id) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    Notifier notifier = await helper.queryNotifier(id);
    if (notifier == null) {
     print('Read: Notifier is null');
    }
    else {
     print(notifier.toString());
    }
  }


  //Reads Entire Database
  readAll() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    List<Notifier> notifier = await helper.queryAllNotifiers();
    if (notifier == null) {
     print('Read All: Database is null');
    }
    else {
     print(notifier.toString());
    }
  }

  //Inserts A Notifier
  write() async {
    Notifier notifier = Notifier();
    notifier.page0NumberData = 0;
    notifier.page0UnitData = 1;
    notifier.page1Data = 0;
    notifier.page2InputData = 1;
    notifier.page2UnitData = 1;
    notifier.page3Data = 0;
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
  update(Notifier notifier) async {
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