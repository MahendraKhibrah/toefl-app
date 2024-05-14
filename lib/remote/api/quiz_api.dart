import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toefl/models/quiz.dart';
import 'package:toefl/models/quiz_type.dart';
import 'package:toefl/remote/base_response.dart';
import 'package:toefl/remote/dio_toefl.dart';
import 'package:toefl/remote/env.dart';

class QuizApi {
  Future<Quiz> fetchQuiz(String id) async {
    try {
      final Response rawResponse = await DioToefl.instance
          .get('${Env.apiUrl}/quizs/6633127d3a99f7fe4cf8a83f');

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
}
