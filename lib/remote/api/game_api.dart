import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toefl/models/game.dart';
import 'package:toefl/remote/list_response.dart';
import 'package:toefl/remote/dio_toefl.dart';
import 'package:toefl/remote/env.dart';

class GameApi {
  Future<List<Game>> fetchGames() async {
    try {
      final Response rawResponse =
          await DioToefl.instance.get('${Env.apiUrl}/games');

      final Map<String, dynamic> decodedResponse =
          json.decode(rawResponse.data);
      final ListResponse listResponse = ListResponse.fromJson(decodedResponse);
      // debugPrint(listResponse.to);
      List<Game> games =
          listResponse.data.map((item) => Game.fromJson(item)).toList();
      debugPrint(games.toString());
      return games;
    } catch (e) {
      debugPrint("err: " + e.toString());
      return [];
    }
  }
}
