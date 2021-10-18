import 'dart:io';

import 'package:data/data.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDatabase {
  static const name = 'db.sql';
  static const version = 1;

  final Logger _logger = Logger('SqfliteDatabase');
  final SqlStatements _sqlStatements = SqlStatements();

  late Database _database;

  Database get database => _database;

  Future<void> clearTables() async {
    var rs = await _database.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table';",
    );

    rs.forEach((Map<String, dynamic> row) async {
      String name = row['name'];
      if (name != 'android_metadata' && name != 'ios_metadata') {
        await _database.execute('DELETE FROM $name');
      }
    });
  }

  Future<int> delete(
    String table, {
    String? columnId,
    List<String>? ids,
  }) async {
    return await _database.delete(
      table,
      where: columnId?.isNotEmpty == true ? '$columnId! = ?' : null,
      whereArgs: ids,
    );
  }

  void dispose() async {
    await _database.close();
  }

  Future<void> initializeDatabase() async {
    try {
      var databasePath = join(await _getDatabasePath(), name);
      await _sqlStatements.initialize();

      _database = await openDatabase(
        databasePath,
        version: version,
        onCreate: (
          Database db,
          int version,
        ) async {
          await _createTables(db);
        },
        onUpgrade: (
          Database db,
          int oldVersion,
          int newVersion,
        ) async {
          await _deleteTables(db);
          await _createTables(db);
        },
      );
    } catch (e, stack) {
      _logger.severe('Error initializing database', e, stack);
    }
  }

  Future<int> insert(
    String table, {
    required Map<String, Object?> values,
  }) async {
    return await _database.insert(
      table,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertAll(
    String table, {
    required List<Map<String, Object?>> values,
  }) async {
    var batch = _database.batch();
    for (var value in values) {
      batch.insert(
        table,
        value,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<Map<String, Object?>>> query(
    String table, {
    required List<String> columns,
  }) async {
    return await _database.query(
      table,
      columns: columns,
    );
  }

  Future<void> _createTables(Database db) async {
    for (var stmt in _sqlStatements.createStatements) {
      await db.execute(stmt);
    }
  }

  Future<void> _deleteTables(Database db) async {
    var rs = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table';",
    );

    rs.forEach((Map<String, dynamic> row) async {
      String name = row['name'];
      if (name != 'android_metadata' && name != 'ios_metadata') {
        await db.execute('DROP TABLE $name');
      }
    });
  }

  Future<String> _getDatabasePath() async {
    String? path;
    if (Platform.isIOS) {
      path = (await getApplicationSupportDirectory()).path;
    }
    path ??= await getDatabasesPath();

    return path;
  }
}
