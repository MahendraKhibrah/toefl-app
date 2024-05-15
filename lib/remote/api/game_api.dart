import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toefl/models/game_data.dart';
import 'package:toefl/remote/base_response.dart';
import 'package:toefl/remote/dio_toefl.dart';
import 'package:toefl/remote/env.dart';
import 'package:toefl/remote/list_response.dart';

class GameApi {
  Future<List<Game>> fetchGames() async {
    try {
      final Response rawResponse =
          await DioToefl.instance.get('${Env.apiUrl}/games');
      final List<dynamic> jsonResponse = json.decode(rawResponse.data)['data'];
      debugPrint(jsonResponse.toString());
      // List<Game> games =
      //     (jsonResponse['data'] as List).map((e) => Game.fromJson(e)).toList();
      //COKK LALI NULLABLE :(())  
      List<Game> games = jsonResponse
          .map((e) => Game.fromJson(e as Map<String, dynamic>))
          .toList();

      return games;
    } catch (e, stacktrace) {
      debugPrint("Error fetching games: $e");
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
      // return []; // Return an empty list if there's an error or no valid data
    }
  }
}
