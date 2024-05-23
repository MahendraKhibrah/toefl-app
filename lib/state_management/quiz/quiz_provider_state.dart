// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:toefl/models/quiz.dart';
import 'package:toefl/models/game_claim.dart';
import 'package:toefl/models/quiz_game_answer.dart';
import 'package:toefl/models/quiz_type.dart';
import 'package:toefl/remote/api/game_api.dart';
import 'package:toefl/remote/api/quiz_api.dart';

part 'quiz_provider_state.freezed.dart';
part 'quiz_provider_state.g.dart';

@freezed
class QuizGame with _$QuizGame {
  factory QuizGame({
    @JsonKey(name: 'claimId') required String id,
    @JsonKey(name: 'user_answer') required List<QuizGameAnswer> userAnswer,
    required Quiz quiz,
    @Default(false) bool isGame,
  }) = _QuizGame;

  factory QuizGame.fromJson(Map<String, dynamic> json) =>
      _$QuizGameFromJson(json);
}

@riverpod
class QuizGames extends _$QuizGames {
  @override
  Future<QuizGame> build() async {
    // print(state);
    return QuizGame(
        id: '',
        isGame: false,
        userAnswer: [],
        quiz: Quiz(
            id: '',
            questions: [],
            quizName: '',
            quizTypeId: '',
            type: QuizType(id: '', name: '', desc: '')));
  }

  Future<void> getClaim(String id, bool isGame) async {
    QuizGame data = await QuizApi().getClaim(id, isGame);
    state = AsyncData(data);
  }
}
