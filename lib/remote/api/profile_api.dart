import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:toefl/models/profile.dart';
import 'package:toefl/remote/base_response.dart';
import 'package:toefl/remote/dio_toefl.dart';
import 'package:toefl/remote/env.dart';

class ProfileApi {
  Future<Profile> getProfile() async {
    try {
      final Response rawResponse =
          await DioToefl.instance.get('${Env.userUrl}/users/profile');

      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      return Profile.fromJson(response.data);
    } catch (e, stackTrace) {
      print(e.toString() + stackTrace.toString());
      return Profile(
          id: "",
          level: "",
          currentScore: 0,
          targetScore: 0,
          nameUser: "",
          emailUser: "");
    }
  }
}
