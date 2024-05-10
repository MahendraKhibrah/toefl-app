import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:toefl/models/login.dart';
import 'package:toefl/remote/base_response.dart';
import 'package:toefl/remote/dio_toefl.dart';
import 'package:toefl/remote/env.dart';

class LoginApi {
  Future<Login> postLogin(String email, String password) async {
    try {
      Map<String, dynamic> data = {
        "email": email,
        "password": password,
      };

      final Response rawResponse = await DioToefl.instance.post(
        '${Env.apiUrl}/login',
        data: jsonEncode(data),
      );

      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      return Login.fromJson(response.data);
    } catch (e) {
      return Login(
          email: "",
          password: "",
          );
    }
  }
}
