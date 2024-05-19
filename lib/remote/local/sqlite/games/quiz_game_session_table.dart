import 'package:sqflite/sqlite_api.dart';
import 'package:toefl/models/games/game_session.dart';
import 'package:toefl/remote/local_database_service.dart';

class QuizGameSessionTable {
  Future<void> onCreate(Database db, int version) async {
    db.execute('''
          CREATE TABLE quiz_game_session(
            id INTEGER PRIMARY KEY,
            quiz_game_claim_id STRING,
            is_completed INTEGER
          )
        ''');
    db.execute('''
          CREATE TABLE quiz_detail_answer(
            id INTEGER PRIMARY KEY,
            quiz_game_id STRING,
            options_id STRING,
            is_true INTEGER
          )
        ''');
  }

  Future<void> insertQuizGameSession(QuizGameSession session) async {
    final db = await LocalDatabaseService().database;
    await db.insert(
      'quiz_game_session',
      session.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<QuizGameSession>> getQuizGameSessions() async {
    final db = await LocalDatabaseService().database;
    final List<Map<String, dynamic>> maps = await db.query('quiz_game_session');
    return List.generate(maps.length, (i) {
      return QuizGameSession.fromMap(maps[i]);
    });
  }

  Future<void> insertQuizDetailAnswer(QuizDetailAnswer answer) async {
    final db = await LocalDatabaseService().database;
    await db.insert(
      'quiz_detail_answer',
      answer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<QuizDetailAnswer>> getQuizDetailAnswers() async {
    final db = await LocalDatabaseService().database;
    final List<Map<String, dynamic>> maps =
        await db.query('quiz_detail_answer');
    return List.generate(maps.length, (i) {
      return QuizDetailAnswer.fromMap(maps[i]);
    });
  }
}
