import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toefl/models/game_claim.dart';
import 'package:toefl/models/game_data.dart';
import 'package:toefl/remote/base_response.dart';
import 'package:toefl/remote/dio_toefl.dart';
import 'package:toefl/remote/env.dart';

class GameApi {
  Future<List<Game>> fetchGames() async {
    try {
      final Response rawResponse =
          await DioToefl.instance.get('${Env.gameUrl}/games');
      final List<dynamic> jsonResponse = json.decode(rawResponse.data)['data'];
      debugPrint(jsonResponse.toString());

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

  Future<List<GameClaim>> getUserGameByGameSet(String gameSetId) async {
    try {
      final Response rawResponse =
          await DioToefl.instance.get('${Env.gameUrl}/gameclaims/$gameSetId');

      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      final Map<String, dynamic> dataGameClaim = response.data;
      List<GameClaim> gameClaim = dataGameClaim['data'];

      return gameClaim;
    } catch (e) {
      return [];
    }
  }

  Future<GameClaim?> getUserGameById(String gameClaimId) async {
    try {
      final Response rawResponse =
          await DioToefl.instance.get('${Env.gameUrl}/gameclaims/$gameClaimId');

      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      GameClaim gameClaim = response.data;

      return gameClaim;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<GameClaim?> claimGame(String gameSetId) async {
    try {
      final Response rawResponse = await DioToefl.instance
          .post('${Env.gameUrl}/gameclaims/', data: {'game_set_id': gameSetId});
      final response = BaseResponse.fromJson(json.decode(rawResponse.data));

      GameClaim gameClaim = response.data;

      return gameClaim;
    } catch (e) {
      return null;
    }
  }

  
}
