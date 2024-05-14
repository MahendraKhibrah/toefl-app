import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:toefl/remote/local_database_service.dart';
import 'package:toefl/utils/utils.dart';

import '../../../models/test/packet_detail.dart';

class FullTestTable {
  final tableName = 'full_test';

  Future<void> createTable(Database database) async {
    const idType = 'STRING';
    const idQuestionType = 'STRING';
    const questionType = 'STRING';
    const answerType = 'STRING';
    const optionType = 'STRING';
    const bookmarkedType = 'INTEGER';
    const numberType = 'INTEGER PRIMARY KEY';
    const categoryType = 'STRING';
    const referenceQuestionType = 'STRING';

    await database.execute('''
      CREATE TABLE $tableName (
        id $idType,
        id_question $idQuestionType,
        question $questionType,
        reference_question $referenceQuestionType,
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
  }

  Future<void> resetDatabase() async {
    final database = await LocalDatabaseService().database;
    await database.execute('DROP TABLE IF EXISTS $tableName');
    await createTable(database);
  }

  void insertQuestion(Question question, int number) async {
    final database = await LocalDatabaseService().database;
    final rawQuery = '''
      INSERT INTO $tableName (id, id_question, question, reference_question, option, bookmarked, number, category)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    ''';
    await database.rawInsert(rawQuery, [
      question.nestedQuestionId,
      question.id,
      question.question,
      question.bigQuestion,
      Utils.listToStringWithAt(
          question.choices.map((e) => e.toStringJson()).toList()),
      0,
      number,
      question.typeQuestion,
    ]);
  }

  Future<Question> getQuestionByNumber(int number) async {
    final database = await LocalDatabaseService().database;
    final rawQuery = '''
      SELECT * FROM $tableName WHERE number = ?
    ''';
    final result = await database.rawQuery(rawQuery, [number]);
    final question = result.first;

    return Question.fromJson({
      'id': question['id_question'],
      'question': question['question'],
      'type_question': question['category'],
      'nested_question_id': question['id'],
      'multiple_choices': multipleChoiceMapper(question['option'] as String),
      'nested_question': question['reference_question'],
      'answer': question['answer'],
      'bookmarked': question['bookmarked'],
      'number': question['number'],
    });
  }

  Future<List<Question>> getQuestionsByGroupId(String id) async {
    final database = await LocalDatabaseService().database;
    final rawQuery = '''
      SELECT * FROM $tableName WHERE id = ?
    ''';
    final result = await database.rawQuery(rawQuery, [id]);
    return result
        .map((e) => Question.fromJson({
              'id': e['id_question'],
              'question': e['question'],
              'type_question': e['category'],
              'nested_question_id': e['id'],
              'multiple_choices': multipleChoiceMapper(e['option'] as String),
              'nested_question': e['reference_question'],
              'answer': e['answer'],
              'bookmarked': e['bookmarked'],
              'number': e['number'],
            }))
        .toList();
  }

  Future<void> updateBookmark(int number, int bookmarked) async {
    final database = await LocalDatabaseService().database;
    final rawQuery = '''
      UPDATE $tableName SET bookmarked = ? WHERE number = ?
    ''';
    await database.rawUpdate(rawQuery, [bookmarked, number]);
  }

  Future<void> updateAnswer(int number, String answer) async {
    final database = await LocalDatabaseService().database;
    final rawQuery = '''
      UPDATE $tableName SET answer = ? WHERE number = ?
    ''';
    await database.rawUpdate(rawQuery, [answer, number]);
  }

  Future<List<String?>> getAllAnswer() async {
    final database = await LocalDatabaseService().database;
    final rawQuery = '''
      SELECT answer FROM $tableName
    ''';
    final result = await database.rawQuery(rawQuery);
    return result.map((e) => e['answer'] as String?).toList();
  }

  List<Map<String, dynamic>> multipleChoiceMapper(String multipleChoices) {
    final List<String> choices = Utils.stringToListWithAt(multipleChoices);
    return choices.map((e) => Choice.fromJsonString(e).toJson()).toList();
  }
}
