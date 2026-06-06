import 'package:cubelab/db/models/model.dart';
import 'package:cubelab/db/services/database_service.dart';
import 'package:cubelab/providers/settings_provider.dart';
import 'package:sqflite/sqflite.dart';

abstract class Repository<T extends Model<T>> {
  Repository({this.settingsProvider});

  SettingsProvider? settingsProvider;
  Database? _database;

  Future<Database> get database async {
    return _database ??= await DatabaseService.instance.database;
  }

  String getTable();
  T newEntity();

  Future<T> findById(int id) async {
    Database db = await database;

    return retryIfLocked(() async {
      return await db.query(getTable(), where: "id = ?", whereArgs: [id]).then((
        result,
      ) {
        return result
            .map((dbEntity) => newEntity().fillFromValues(dbEntity))
            .single;
      });
    });
  }

  Future<List<T>> findAll() async {
    Database db = await database;

    return retryIfLocked(() async {
      return await db.query(getTable()).then((result) {
        return result
            .map((dbEntity) => newEntity().fillFromValues(dbEntity))
            .toList();
      });
    });
  }

  Future<List<T>> findBy({
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    Database db = await database;

    return retryIfLocked(() async {
      return await db
          .query(
            getTable(),
            distinct: distinct,
            columns: columns,
            where: where,
            whereArgs: whereArgs,
            groupBy: groupBy,
            having: having,
            orderBy: orderBy,
            limit: limit,
            offset: offset,
          )
          .then((result) {
            return result
                .map((dbEntity) => newEntity().fillFromValues(dbEntity))
                .toList();
          });
    });
  }

  Future<bool> exists(int id) async {
    return findBy(
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    ).then((result) => result.isNotEmpty);
  }

  Future<int> create(T entity) async {
    Database db = await database;

    return retryIfLocked(() async {
      return await db.insert(getTable(), entity.getValuesMap());
    });
  }

  Future<int> update(T entity) async {
    Database db = await database;

    return retryIfLocked(() async {
      return await db.update(
        getTable(),
        entity.getValuesMap(),
        where: 'id = ?',
        whereArgs: [entity.id],
      );
    });
  }

  Future<bool> delete(T entity) async {
    int id = entity.id!;

    return await deleteById(id);
  }

  Future<bool> deleteById(int id) async {
    Database db = await database;

    return retryIfLocked(() async {
      return await db.delete(getTable(), where: "id = ?", whereArgs: [id]) == 0;
    });
  }

  Future<R> retryIfLocked<R>(Future<R> Function() action) async {
    const maxRetries = 3;
    const delay = Duration(milliseconds: 50);

    for (int attempt = 0; attempt < maxRetries; attempt++) {
      try {
        return await action();
      } catch (e) {
        if (e.toString().contains('database is locked') &&
            attempt < maxRetries - 1) {
          await Future.delayed(delay);
          continue;
        }
        rethrow;
      }
    }

    // Unreachable, but Dart requires a return
    throw StateError('Unreachable');
  }
}
