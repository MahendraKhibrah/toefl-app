import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:toefl/models/game_claim.dart';
import 'package:toefl/models/game_data.dart';
import 'package:toefl/models/games/game_session.dart';
import 'package:toefl/models/quiz.dart';
import 'package:toefl/remote/api/game_api.dart';
import 'package:toefl/remote/api/quiz_api.dart';
import 'package:toefl/remote/local/sqlite/games/quiz_game_session_table.dart';

part 'game_provider_state.freezed.dart';
part 'game_provider_state.g.dart';

@freezed
class GameProviderState with _$GameProviderState {
  factory GameProviderState({
    required List<Game> game,
  }) = _GameProviderState;
}

@riverpod
class GameProviderStates extends _$GameProviderStates {
  final QuizGameSessionTable tableGameSession = QuizGameSessionTable();

  @override
  Future<List<Game>> build() async {
    return await GameApi().fetchGames();
  }

  // List<Game> getListGames() {
  //   final games = ref.watch(gameProviderStatesProvider.future);

  //   return games;
  // }

  Future<List<GameClaim>> getUserGameClaim(String gameSetId) async {
    return await GameApi().getUserGameByGameSet(gameSetId);
  }

  Future<GameClaim?> getUserGameQuiz(String gameClaimId) async {
    return await GameApi().getUserGameById(gameClaimId);
  }

  Future<String> findGameNotCompletedYetByUser() async {
    List<QuizGameSession> storedGameSession =
        await tableGameSession.getQuizGameSessions();
    String notCompletedYetId = '';
    for (var session in storedGameSession) {
      if (session.isCompleted == false) {
        notCompletedYetId = session.quizGameClaimId;
        break;
      }
    }

    return notCompletedYetId;
  }

  // Future<bool> insertOrUpdateGameClaim(String gameSetId) async {
    
  // }
}
