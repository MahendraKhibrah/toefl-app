import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:toefl/models/quiz.dart';
import 'package:toefl/models/game_claim.dart';
import 'package:toefl/models/quiz_type.dart';
import 'package:toefl/remote/api/game_api.dart';
import 'package:toefl/remote/api/quiz_api.dart';

part 'quiz_provider_state.freezed.dart';
part 'quiz_provider_state.g.dart';

@freezed
class QuizProviderState with _$QuizProviderState {
  factory QuizProviderState({
    required Quiz quiz,
  }) = _QuizProviderState;
}

@riverpod
class QuizProviderStateNotifier extends _$QuizProviderStateNotifier {
  @override
  Future<Quiz> build(String id) async {
    return QuizApi().fetchQuiz(id);
  }

  Future<List<GameClaim>> getUserGames() async {
    return QuizApi().getUserGames();
  }

  // Future<Game> getUserGameById(String id) async {
  //   return GameApi().fetchGames();
  // }
  
  Future<bool> isRetake(String gameSetId) async {
    bool isRetake = false;
    List<GameClaim> isThereAny =
        await GameApi().getUserGameByGameSet(gameSetId);
    try { 
      return isRetake;
    } catch (e) {
      return isRetake;
    }
  }
}

@riverpod
class QuizGame extends _$QuizGame {
  @override
  Future<Quiz> build(String gameClaimId) async {
    final gameClaim = await GameApi().getUserGameById(gameClaimId);
    Quiz quiz = gameClaim!.gameSet!.quiz!;
    return quiz;
  }
}
