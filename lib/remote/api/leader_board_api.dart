import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toefl/models/leader_board.dart';
import 'package:toefl/remote/base_response.dart';
import 'package:toefl/remote/dio_toefl.dart';
import 'package:toefl/remote/env.dart';

class LeaderBoardApi {
  Future<List<LeaderBoard>> getLeaderBoardEntries() async {
    try {
      final Response rawResponse =
          await DioToefl.instance.get('${Env.apiUrl}/leaderboard');
      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      
      // Assuming the response data is a list of leaderboard entries
      List<dynamic> data = response.data;
      List<LeaderBoard> leaderBoardEntries = data.map((entry) => LeaderBoard.fromJson(entry)).toList();
      
      return leaderBoardEntries;
    } catch (e, stack) {
      debugPrint("Error fetching leaderboard: " + e.toString() + stack.toString());
      return [];
    }
  }
}
