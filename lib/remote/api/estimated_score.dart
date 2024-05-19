import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toefl/models/estimated_score.dart';
import 'package:toefl/remote/base_response.dart';
import 'package:toefl/remote/dio_toefl.dart';
import 'package:toefl/remote/env.dart';

class EstimatedScoreApi {
  Future<EstimatedScore> getEstimatedScore() async {
    try {
      final Response rawResponse =
          await DioToefl.instance.get('${Env.apiUrl}/get-score-toefl');
      // debugPrint(json.decode(rawResponse.data)['data'].toString());
      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      // debugPrint(response.toString());
      return EstimatedScore.fromJson(response.data);
    } catch (e, stack) {
      debugPrint("aa" + e.toString() + stack.toString());
      return EstimatedScore(
          targetUser: 0,
          userScore: 0,
          scoreListening: 0,
          scoreStructure: 0,
          scoreReading: 0);
    }
  }
}
