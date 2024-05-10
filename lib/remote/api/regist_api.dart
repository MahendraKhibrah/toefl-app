import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:toefl/models/regist.dart';
import 'package:toefl/remote/base_response.dart';
import 'package:toefl/remote/dio_toefl.dart';
import 'package:toefl/remote/env.dart';

class RegistApi {
  Future<Regist> postRegist(String name, String email, String password,
      String passwordConfirmation) async {
    try {
      Map<String, dynamic> data = {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation
      };

      final Response rawResponse = await DioToefl.instance.post(
        '${Env.apiUrl}/register',
        data: jsonEncode(data),
      );

      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      return Regist.fromJson(response.data);
    } catch (e) {
      return Regist(
        name: "",
        email: "",
        password: "",
        passwordConfirmation: "",
      );
    }
  }
}
