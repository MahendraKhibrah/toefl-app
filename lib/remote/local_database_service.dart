import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toefl/remote/local/sqlite/final_test_table.dart';

class LocalDatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    final path = await fullPath;
    _database = await openDatabase(path, version: 1, onCreate: create);
    return _database!;
  }

  Future<void> create(Database database, int version) async {
    await FinalTestTable().createTable(database);
  }

  Future<void> close() async {
    await _database?.close();
  }

  Future<String> get fullPath async {
    const name = 'toefl.db';
    final path = await getDatabasesPath();

    return join(path, name);
  }
}
