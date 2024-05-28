import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:toefl/remote/base_response.dart';
import 'package:toefl/remote/dio_toefl.dart';
import 'package:toefl/remote/env.dart';

class ScrambledWordApi {
  Future<bool> storeScrambled(String wordId, bool isTrue) async {
    try {
      final Response rawResponse = await DioToefl.instance.post(
          '${Env.apiUrl}/scrambledword',
          data: {'word_id': wordId, 'is_true': isTrue});

      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      return response.data;
    } catch (e) {
      return false;
    }
  }
}
