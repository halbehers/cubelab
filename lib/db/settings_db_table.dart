import 'package:cubelab/db/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class SettingsDbTable {
  static final String settingsTableName = DatabaseTable.settings;
  static final String settingsIdColumnName = "id";
  static final String settingsNameColumnName = "name";
  static final String settingsValueColumnName = "value";
  static final String settingsValueTypeColumnName = "value_type";

  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $settingsTableName (
        $settingsIdColumnName INTEGER PRIMARY KEY,
        $settingsNameColumnName TEXT NOT NULL UNIQUE,
        $settingsValueColumnName TEXT NOT NULL,
        $settingsValueTypeColumnName TEXT NOT NULL
      );
      ''');
  }
}
