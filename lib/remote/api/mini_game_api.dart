import 'dart:convert';

import 'package:dio/dio.dart';
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
}
