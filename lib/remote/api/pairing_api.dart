import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:toefl/remote/base_response.dart';
import 'package:toefl/remote/dio_toefl.dart';
import 'package:toefl/remote/env.dart';

class PairingApi {
  Future<bool> storeSynonym(List<String> synonymWordIds, int score) async {
    try {
      final Response rawResponse = await DioToefl.instance.post(
          '${Env.gameUrl}/pairingclaims',
          data: {'score': score, 'synonym_words': synonymWordIds});

      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      return response.data;
    } catch (e) {
      return false;
    }
  }
}
