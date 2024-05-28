import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toefl/models/game_claim.dart';
import 'package:toefl/models/quiz.dart';
import 'package:toefl/models/quiz_game_result.dart';
import 'package:toefl/models/quiz_type.dart';
import 'package:toefl/remote/base_response.dart';
import 'package:toefl/remote/dio_toefl.dart';
import 'package:toefl/remote/env.dart';
import 'package:toefl/state_management/quiz/quiz_provider_state.dart';

abstract class IQuizApi {
  Future<Quiz> fetchQuiz(String id);
}

class QuizApi implements IQuizApi {
  @override
  Future<Quiz> fetchQuiz(String id) async {
    try {
      final Response rawResponse =
          await DioToefl.instance.get('${Env.apiUrl}/quizs/$id');

      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      return Quiz.fromJson(response.data);
    } catch (e) {
      debugPrint("err" + e.toString());
      return Quiz(
          id: '',
          questions: [],
          quizName: '',
          quizTypeId: '',
          type: QuizType(id: '', desc: '', name: ''));
    }
  }

  Future<List<GameClaim>> getUserGames() async {
    try {
      final Response rawResponse =
          await DioToefl.instance.get('${Env.apiUrl}/gameclaims');
      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      final Map<String, dynamic> dataResponse = response.data;
      List<GameClaim> gameclaim = dataResponse['data'];

      return gameclaim;
    } catch (e) {
      return [];
    }
  }

  Future<QuizGame> getClaim(String id, bool isGame) async {
    try {
      final Response rawResponse = await DioToefl.instance.post(
          '${Env.apiUrl}/${isGame ? 'gameclaims' : 'quizclaims'}',
          data: isGame ? {'game_set_id': id} : {'quiz_id': id});
      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      final Map<String, dynamic> dataResponse = response.data;
      dataResponse['isGame'] = isGame;
      // print(response.toString());
      return QuizGame.fromJson(dataResponse);
    } catch (e) {
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
  }

  Future<QuizGame> getReview(String id, bool isGame) async {
    try {
      final Response rawResponse = await DioToefl.instance
          .get('${Env.apiUrl}/${isGame ? 'gameclaims' : 'quizclaims'}/$id');
      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      final Map<String, dynamic> dataResponse = response.data;
      dataResponse['isGame'] = isGame;
      // print(response.toString());
      return QuizGame.fromJson(dataResponse);
    } catch (e) {
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
  }

  Future<bool> postAnswer(String quizOptionId, String quizContentId,
      String claim, bool isGame) async {
    try {
      final Response rawResponse = await DioToefl.instance
          .post('${Env.apiUrl}/${isGame ? 'gameanswer' : 'quizanswer'}',
              data: isGame
                  ? {
                      'quiz_option_id': quizOptionId,
                      'quiz_content_id': quizContentId,
                      'game_claim_id': claim,
                    }
                  : {
                      'quiz_option_id': quizOptionId,
                      'quiz_content_id': quizContentId,
                      'quiz_claim_id': claim,
                    });
      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      final Map<String, dynamic> dataResponse = response.data;
      return dataResponse as bool;
    } catch (e) {
      return false;
    }
  }

  Future<QuizGameResult> getResult(String claimId, bool isGame) async {
    try {
      final Response rawResponse = await DioToefl.instance
          .post('${Env.apiUrl}/${'quizgameresult'}', data: {
        'is_game': isGame,
        'claim_id': claimId,
      });
      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      final Map<String, dynamic> dataResponse = response.data;
      return QuizGameResult.fromJson(dataResponse);
    } catch (e) {
      return QuizGameResult(total: 1, benar: 1, score: 0);
    }
  }
}
