import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toefl/models/login.dart';
import 'package:toefl/remote/api/user_api.dart';
import 'package:toefl/remote/test_http_interceptor.dart';

@GenerateNiceMocks([MockSpec<UserApi>()])
import 'auth_test_api_test.mocks.dart';

void main() {
  final token =
      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbG9rYWJlc3RhcmkubGl2ZS9hcGkvZm9yZ290IiwiaWF0IjoxNzE2OTYwMDE0LCJleHAiOjE3MjM0NDAwMTQsIm5iZiI6MTcxNjk2MDAxNCwianRpIjoiMmZPSnJHUEc3OWl6VDdJRiIsInN1YiI6IjY2NTU4MWNkNDU1ZjcwZWI1YzAxMWE5OSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.oxcYTajlBbxPeB4cE-w68b_8cn7QciH6A0fr1A0rX2I";
  // final token = "";
  final Dio dio = Dio(
    BaseOptions(
      responseType: ResponseType.plain,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": token,
      },
    ),
  )..interceptors.add(TestHttpInterceptor());
  final UserApi userApi = UserApi(dio: dio);

  group("Auth Test Api", () {
    group("login", () {
      test("IF SUCCESS", () async {
        try {
          final result = await userApi.postLogin(Login(
              email: "mahendrakhibrah@it.student.pens.ac.id",
              password: "password"));
          debugPrint("hasil : ${result.isSuccess}");
        } catch (e) {
          debugPrint(e.toString());
        }
      });
    });

    //getOtp
    group("getOtp", () {
      test("IF SUCCESS", () async {
        try {
          await userApi.getOtp();
        } catch (e) {
          debugPrint(e.toString());
        }
      });
    });

    group("verifyOtp", () {
      test("If Success", () async {
        try {
          await userApi.verifyOtp("3642");
        } catch (e) {
          debugPrint(e.toString());
        }
      });
    });

    group("forgotPassword", () {
      test("If Success", () async {
        try {
          await userApi.forgotPassword("mahendrakhibrah@it.student.pens.ac.id");
        } catch (e) {
          debugPrint(e.toString());
        }
      });
    });

    group("verifyForgotPassword", () {
      test("If Success", () async {
        try {
          await userApi.verifyForgot("1234");
        } catch (e) {
          debugPrint(e.toString());
        }
      });
    });

    group("verifyPassword", () {
      test("If Success", () async {
        try {
          await userApi.verifyPassword("password");
        } catch (e) {
          debugPrint(e.toString());
        }
      });
    });

    group("changePassword", () {
      test("If Success", () async {
        try {
          await userApi.updatePassword("password1", "password1");
        } catch (e) {
          debugPrint(e.toString());
        }
      });
    });
  });
}
