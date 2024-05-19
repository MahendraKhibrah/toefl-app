import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toefl/models/game_claim.dart';
import 'package:toefl/models/quiz.dart';
import 'package:toefl/models/quiz_type.dart';
import 'package:toefl/remote/base_response.dart';
import 'package:toefl/remote/dio_toefl.dart';
import 'package:toefl/remote/env.dart';

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
}
