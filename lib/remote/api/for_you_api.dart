import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:toefl/models/home_page/learning_path_model.dart';
import 'package:toefl/models/quiz.dart';
import 'package:toefl/remote/base_response.dart';
import 'package:toefl/remote/dio_toefl.dart';
import 'package:toefl/remote/env.dart';

class ForYouApi {
  Future<List<Quiz>> fetchForYou() async {
    try {
      final Response rawResponse =
          await DioToefl.instance.get('${Env.gameUrl}/foryou');
      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      final List<dynamic> data = response.data;
      List<Quiz> quizs =
          data.map((e) => Quiz.fromJson(e)).toList();
      return quizs;
    } catch (e) {
      return [];
    }
  }
}
