import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:toefl/models/profile.dart';
import 'package:toefl/models/target_onboarding.dart';
import 'package:toefl/remote/base_response.dart';
import 'package:toefl/remote/dio_toefl.dart';
import 'package:toefl/remote/env.dart';

class OnBoardingApi {
  Future<List<TargetOnboarding>> getTarget() async {
    try {
      final Response rawResponse =
          await DioToefl.instance.get('${Env.mainUrl}/get-onboarding-target');

      final response = BaseResponse.fromJson(json.decode(rawResponse.data));
      final List<dynamic> data = response.data;
      print(data);
      List<TargetOnboarding> targets =
          data.map((entry) => TargetOnboarding.fromJson(entry)).toList();

      return targets;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
