import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:toefl/models/user.dart';
import 'package:toefl/remote/base_response.dart';
import 'package:toefl/remote/dio_toefl.dart';
import 'package:toefl/remote/env.dart';

class UserApi {
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
}
