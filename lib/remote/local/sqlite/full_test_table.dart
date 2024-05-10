import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toefl/remote/local_database_service.dart';

class FullTestTable {
  final tableName = 'full_test';

  Future<void> createTable(Database database) async {
    const idType = 'STRING PRIMARY KEY';
    const idQuestionType = 'STRING';
    const questionType = 'STRING';
    const answerType = 'STRING';
    const optionType = 'STRING';
    const bookmarkedType = 'INTEGER';
    const numberType = 'INTEGER';
    const categoryType = 'STRING';

    await database.execute('''
      CREATE TABLE $tableName (
        id $idType,
        id_question $idQuestionType,
        question $questionType,
        answer $answerType,
        option $optionType,
        bookmarked $bookmarkedType,
        number $numberType,
        category $categoryType
      )
    ''');
  }

  void getFullTestTest() async {
    final database = await LocalDatabaseService().database;
    final result = await database.query(tableName);
    debugPrint("result: $result");
  }

  Future<void> resetDatabase(Database database) async {
    await database.execute('DROP TABLE IF EXISTS $tableName');
    await createTable(database);
  }
}
