

//Dependencies
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class Notifier {

    //Identification
    final int id;

    //First Page Data
    final int page0NumberData;
    final int page0UnitData;

    //Second Page Data
    final int page1Data;

    //Third Page Data
    final int page2UnitData;
    final int page2InputData;

    //Fourth Page Data
    final int page3Data;

    Notifier({this.id, this.page0NumberData, this.page0UnitData, this.page1Data, this.page2InputData, this.page2UnitData, this.page3Data});

    Map<String, dynamic> toMap() {
      return {
        'id': id,
        'page0NumberData': page0NumberData,
        'page0UnitData': page0UnitData,
        'page1Data': page1Data,
        'page2UnitData': page2UnitData,
        'page2InputData': page2InputData,
        'page3Data': page3Data,
      };
    }

}


class NotifierDatabase {

  NotifierDatabase._privateConstructor();
  static final NotifierDatabase instance = NotifierDatabase._privateConstructor();

  void main() async {

  //Opens Connection To Database
  final Future<Database> notifierdatabase = openDatabase(

    //Opens Connection
    join(await getDatabasesPath(), 'notifier_database.db'),
    
    //Creates Table
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE notifiers(id INTEGER PRIMARY KEY, notifierPage0NumberData INTEGER, notifierPage0UnitData INTEGER, notifierPage1Data INTEGER, notifierPage2UnitData INTEGER, notifierPage2InputData INTEGER, notifierPage3Data INTEGER)",
        );
      },

    //For Upgrading and Downgrading  
    version: 1,

    );

  //A method to insert notifiers into the database
  Future<void> insertNotifier(Notifier notifier) async {

    //References Database
    final Database db = await notifierdatabase;

    //Replaces Data
    await db.insert(
      'notifiers',
      notifier.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    
  }

  //A method to list out all the data
  Future<List<Notifier>> notifiers() async {

    //Reference the main database
    final Database db = await notifierdatabase;

    //Query all the data
    final List<Map<String, dynamic>> notifierMaps = await db.query('notifiers');

    //Translate map into Notifier
    return List.generate(notifierMaps.length, (i) {
      return Notifier(
          id: notifierMaps[i]['id'],
          page0NumberData: notifierMaps[i]['page0NumberData'],
          page0UnitData: notifierMaps[i]['page0UnitData'],
          page1Data: notifierMaps[i]['page1Data'],
          page2InputData: notifierMaps[i]['page2InputData'],
          page2UnitData: notifierMaps[i]['page2UnitData'],
          page3Data: notifierMaps[i]['page3Data'],
        );
      }
    );
  }

  //Prints out queried data
  print(await notifiers());

  Future<void> deleteNotifier(int id) async {

    //Reference database
    final db = await notifierdatabase;

    //Removes notifier
    await db.delete(
      
      //Finds table
      'notifiers',

      //Use a where clause to find a specific notifier
      where:  "id = ?",

      //This passes the notifier's id to find the specific one
      whereArgs: [id],

    );
  }

  //Delete this
  print(deleteNotifier(0).toString());

  //Sample Data
  final aapl = Notifier(
    id: 0,
    page0NumberData: 2,
    page0UnitData: 1,
    page1Data: 0,
    page2InputData: 1,
    page2UnitData: 1,
    page3Data: 0,
  );

  await insertNotifier(aapl);

  }
}