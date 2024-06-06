import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:toefl/models/home_page/learning_path_model.dart';
import 'package:toefl/models/quiz.dart';
import 'package:toefl/remote/base_response.dart';
import 'package:toefl/remote/dio_toefl.dart';
import 'package:toefl/remote/env.dart';

class LearningPathApi {
  Future<List<LearningPathModel>> getLearning() async {
    try {
      final Response rawResponse =
          await DioToefl.instance.get('${Env.gameUrl}/quiztypes');
      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      final List<dynamic> dataTypes = response.data;
      List<LearningPathModel> types =
          dataTypes.map((e) => LearningPathModel.fromJson(e)).toList();
      return types;
    } catch (e) {
      return [];
    }
  }

  Future<List<Quiz>> getQuizByCategory(String id) async {
    try {
      final Response rawResponse =
          await DioToefl.instance.get('${Env.gameUrl}/quiztypes/$id');
      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      final List<dynamic> dataTypes = response.data;
      List<Quiz> quizzes = dataTypes.map((e) => Quiz.fromJson(e)).toList();
      return quizzes;
    } catch (e) {
      return [];
    }
  }
}
