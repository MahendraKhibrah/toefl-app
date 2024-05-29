import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:toefl/exceptions/exceptions.dart';
import 'package:toefl/models/auth_status.dart';
import 'package:toefl/models/test/test_target.dart';
import 'package:toefl/models/user.dart';
import 'package:toefl/remote/base_response.dart';
import 'package:toefl/remote/dio_toefl.dart';
import 'package:toefl/remote/env.dart';
import 'package:toefl/remote/local/shared_pref/auth_shared_preferences.dart';

import '../../models/login.dart';
import '../../models/regist.dart';

class UserApi {
  final Dio? dio;

  UserApi({this.dio});

  AuthSharedPreference authSharedPreference = AuthSharedPreference();

  Future<User> getProfile() async {
    try {
      final Response rawResponse =
          await (dio ?? DioToefl.instance).get('${Env.apiUrl}/users/profile');
      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      return User.fromJson(response.data);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<AuthStatus> postLogin(Login request) async {
    try {
      final Response rawResponse = await (dio ?? DioToefl.instance).post(
        '${Env.apiUrl}/login',
        data: request.toJson(),
      );

      final token = json.decode(rawResponse.data)['token'];
      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      final AuthStatus authStatus = AuthStatus.fromJson(response.data);
      await authSharedPreference.saveBearerToken(token);
      return authStatus.copyWith(isSuccess: true);
    } catch (e) {
      return AuthStatus(isVerified: false, isSuccess: false);
    }
  }

  Future<AuthStatus> postRegist(Regist request) async {
    try {
      final Response rawResponse = await DioToefl.instance.post(
        '${Env.apiUrl}/register',
        data: request.toJson(),
      );

      final token = json.decode(rawResponse.data)['token'];
      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      final AuthStatus authStatus = AuthStatus.fromJson(response.data);
      await authSharedPreference.saveBearerToken(token);
      return authStatus.copyWith(isSuccess: true);
    } catch (e) {
      return AuthStatus(isVerified: false, isSuccess: false);
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

  Future<bool> getOtp() async {
    try {
      final response =
          await (dio ?? DioToefl.instance).post('${Env.apiUrl}/users/new-otp');
      debugPrint('response: ${json.decode(response.data)}');
      return true;
    } catch (e) {
      debugPrint('error get otp: $e');
      return false;
    }
  }

  Future<AuthStatus> verifyOtp(String otp) async {
    try {
      final rawResponse = await (dio ?? DioToefl.instance)
          .post('${Env.apiUrl}/users/verify-otp', data: {'otp_register': otp});
      final response = json.decode(rawResponse.data);
      debugPrint('response: ${response['success']}');
      return AuthStatus(isVerified: response['success'], isSuccess: true);
    } catch (e) {
      debugPrint('error verify otp: $e');
      return AuthStatus(isVerified: false, isSuccess: false);
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      final rawResponse =
          await (dio ?? DioToefl.instance).post('${Env.apiUrl}/forgot', data: {
        'email': email,
      });
      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      debugPrint('success : ${response.data['token']}');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> verifyForgot(String otp) async {
    try {
      final rawResponse = await (dio ?? DioToefl.instance)
          .post('${Env.apiUrl}/users/verify-otp-forgot', data: {
        'otp_forgot': otp,
      });
      debugPrint('success : ${json.decode(rawResponse.data)['success']}');
      return json.decode(rawResponse.data)?['success'] ?? true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> verifyPassword(String password) async {
    try {
      final rawResponse = await (dio ?? DioToefl.instance)
          .post('${Env.apiUrl}/check/password', data: {
        'password': password,
      });
      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      debugPrint('success : ${response.data['password']}');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updatePassword(String password, String secondPassword) async {
    try {
      final rawResponse = await (dio ?? DioToefl.instance)
          .post('${Env.apiUrl}/change/password', data: {
        'password': password,
        'confirm_password': secondPassword,
      });

      debugPrint('success : ${json.decode(rawResponse.data)?['success']}');
      return json.decode(rawResponse.data)?['success'] ?? true;
    } catch (e) {
      return false;
    }
  }
}
