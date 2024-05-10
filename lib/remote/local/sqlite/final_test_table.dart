import 'package:sqflite/sqlite_api.dart';

class FinalTestTable {
  final tableName = 'final_test';

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

  Future<void> resetDatabase(Database database) async {
    await database.execute('DROP TABLE IF EXISTS $tableName');
    await createTable(database);
  }
}
