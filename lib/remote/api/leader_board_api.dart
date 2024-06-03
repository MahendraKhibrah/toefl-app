import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toefl/models/games/user_rank.dart';
import 'package:toefl/models/leader_board.dart';
import 'package:toefl/models/user.dart';
import 'package:toefl/remote/base_response.dart';
import 'package:toefl/remote/dio_toefl.dart';
import 'package:toefl/remote/env.dart';

class LeaderBoardApi {
  Future<UserRank> getLeaderBoardEntries() async {
    try {
      final Response rawResponse =
          await DioToefl.instance.get('${Env.gameUrl}/leaderboard');
      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      // Assuming the response data is a list of leaderboard entries
      String user = response.data['user']["_id"];
      List<dynamic> data = response.data['rank'];
      List<LeaderBoard> leaderBoardEntries =
          data.map((entry) => LeaderBoard.fromJson(entry)).toList();

      return UserRank(data: leaderBoardEntries, userId: user);
    } catch (e, stack) {
      debugPrint("Error fetching leaderboard: $e$stack");
      return UserRank(userId: '');
    }
  }
}
