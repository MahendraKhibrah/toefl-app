import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toefl/models/games/game_history.dart';
import 'package:toefl/remote/base_response.dart';
import 'package:toefl/remote/dio_toefl.dart';
import 'package:toefl/remote/env.dart';

class MiniGameApi {
  Future<bool> storeScrambledWord(String wordId, bool isTrue) async {
    try {
      final Response rawResponse = await DioToefl.instance.post(
          '${Env.gameUrl}/minigames/scrambled=word-game',
          data: {'word_id': wordId, 'is_true': isTrue});

      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      return response.data;
    } catch (e) {
      return false;
    }
  }

  Future<bool> storePairingSynonym(
      List<String> synonymWordIds, double score) async {
    try {
      final Response rawResponse = await DioToefl.instance.post(
          '${Env.gameUrl}/minigames/pairing-game',
          data: {'score': score, 'synonym_words': synonymWordIds});

      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      return response.data;
    } catch (e) {
      return false;
    }
  }

  Future<bool> storeScrambledTense(String tenseId, bool isTrue) async {
    try {
      final Response rawResponse = await DioToefl.instance.post(
          '${Env.gameUrl}/minigames/scrambled-tense-game',
          data: {'tense_id': tenseId, 'is_true': isTrue});

      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      return response.data;
    } catch (e) {
      return false;
    }
  }

  Future<bool> storeSpeakingTense(String tenseId, double score) async {
    try {
      final Response rawResponse = await DioToefl.instance.post(
          '${Env.gameUrl}/minigames/speaking-game',
          data: {'tense_id': tenseId, 'score': score});

      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      return response.data;
    } catch (e) {
      return false;
    }
  }

  Future<List<GameHistory>> getHistoryGame({String? id = ''}) async {
    try {
      final Response rawResponse = await DioToefl.instance
          .get('${Env.gameUrl}/minigames/user-history/$id');
      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      final List<dynamic> data = response.data;
      List<GameHistory> dataGameHistory =
          data.map((entry) => GameHistory.fromJson(entry)).toList();

      print('ANJAY' + dataGameHistory.toString());
      return dataGameHistory;
    } catch (e, stack) {
      debugPrint(e.toString() + stack.toString());
      return [];
    }
  }
}
