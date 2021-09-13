import 'package:clock_app/models/alarm_info.dart';
import 'package:sqflite/sqflite.dart';

final String tableAlarm = 'alarm';
final String columnId = 'id';
final String columnTitle = 'Title';
final String columnDateTime = 'alarmDateTime';
final String columnPending = 'isPending';
final String columnColorIndex = 'gradientColorIndex';

class AlarmHelper {
  static Database? _database;
//Creating Singleton instance of dart so it can be easily accessible
  static AlarmHelper? _alarmHelper;

  AlarmHelper._crateInstance(); //It is private constructor
  factory AlarmHelper() {
    if (_alarmHelper == null) {
      _alarmHelper = AlarmHelper._crateInstance();
    }
    return _alarmHelper!;
  }
  //This is how you create singleton instance at dart

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "alarm.db";
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $tableAlarm(
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnTitle TEXT NOT NULL,
          $columnDateTime TEXT NOT NULL,
          $columnPending BOOLEAN NOT NULL,
          $columnColorIndex INTETGER NOT NULL )

        
        ''');
      },
    );
    return database;
  }

  void insertAlarm(AlarmInfo alarmInfo) async {
    var db = await this.database;
    var result = await db.insert(tableAlarm, alarmInfo.toJson());
    print('result:$result');
  }

  Future<List<AlarmInfo>> getAlarms() async {
    var db = await this.database;
    var result = await db.query(tableAlarm);
    List<AlarmInfo> _alarmsList = List<AlarmInfo>.empty(growable: true);
    result.forEach((element) {
      var alarmInfo = AlarmInfo.fromJson(element);
      _alarmsList.add(alarmInfo);
    });
    return _alarmsList;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db.delete(tableAlarm, where: '$columnId=?', whereArgs: [id]);
  }
}
