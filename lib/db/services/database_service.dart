import 'package:flutter/foundation.dart';
import 'package:cubelab/db/migrations.dart';
import 'package:cubelab/db/settings_db_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseTable {
  static String settings = "settings";
  static String events = "events";
}

class DatabaseService {
  DatabaseService._privateConstructor();
  static final DatabaseService instance = DatabaseService._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  Migrations migrations = Migrations();

  Future<Database> _initDatabase() async {
    final String databaseDirectoryPath = await getDatabasesPath();
    final String path = join(databaseDirectoryPath, "cubelab.db");

    final Database database = await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );

    if (kDebugMode) {
      debugPrint('Database initialized!');
      debugPrint('Path to db: $databaseDirectoryPath');
    }

    return database;
  }

  Future _onCreate(Database db, int version) async {
    SettingsDbTable.createTable(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.transaction((txn) async {});
  }
}
