import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:toefl/models/test/test_target.dart';
import 'package:toefl/models/user.dart';
import 'package:toefl/remote/base_response.dart';
import 'package:toefl/remote/dio_toefl.dart';
import 'package:toefl/remote/env.dart';
import 'package:toefl/remote/local/shared_pref/auth_shared_preferences.dart';

import '../../models/login.dart';
import '../../models/regist.dart';

class UserApi {
  AuthSharedPreference authSharedPreference = AuthSharedPreference();

  Future<User> getProfile() async {
    try {
      final Response rawResponse =
          await DioToefl.instance.get('${Env.apiUrl}/users/profile');

      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      return User.fromJson(response.data);
    } catch (e) {
      return User(
          id: "",
          level: "",
          currentScore: "",
          targetScore: "",
          nameUser: "",
          emailUser: "");
    }
  }

  Future<bool> postLogin(Login request) async {
    try {
      final Response rawResponse = await DioToefl.instance.post(
        '${Env.apiUrl}/login',
        data: request.toJson(),
      );

      final token = json.decode(rawResponse.data)['token'];
      await authSharedPreference.saveBearerToken(token);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> postRegist(Regist request) async {
    try {
      final Response rawResponse = await DioToefl.instance.post(
        '${Env.apiUrl}/register',
        data: request.toJson(),
      );

      final token = json.decode(rawResponse.data)['token'];
      await authSharedPreference.saveBearerToken(token);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserTarget> getUserTarget() async {
    try {
      final Response rawResponse =
          await DioToefl.instance.get('${Env.apiUrl}/get-all/targets');

      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      return UserTarget.fromJson(response.data);
    } catch (e) {
      debugPrint("Error in getUserTarget: $e");
      return UserTarget(
          selectedTarget: TestTarget(id: "", name: "", score: 0),
          allTargets: []);
    }
  }

  Future<bool> updateBookmark(String id) async {
    try {
      await DioToefl.instance
          .patch('${Env.apiUrl}/add-and-patch-target', data: {
        'target_id': id,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
