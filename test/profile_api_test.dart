import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toefl/remote/api/profile_api.dart';
import 'package:toefl/remote/test_http_interceptor.dart';

void main() {
  const token =
      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3VzZXIuY2lwdGFrb2RlLmJpei5pZC9hcGkvbG9naW4iLCJpYXQiOjE3MTc0OTQ0NDAsImV4cCI6MTcyMzk3NDQ0MCwibmJmIjoxNzE3NDk0NDQwLCJqdGkiOiJrRFdpWHFJbzJsbnI2c3AyIiwic3ViIjoiNjY1NDA1NGRiODAyOWQ2YTU2MGNhZWEyIiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.qcMqlodNmDpYiS0PPNPTldb3dpqALVBQJZD82u8NYEM";
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
  final ProfileApi userApi = ProfileApi(dio: dio);

  group("Auth Test Api", () {
    group("getUserProfile", () {
      test("IF SUCCESS", () async {
        try {
          final result =
              await userApi.getUserProfile("663e23261541f85640071622");
          debugPrint("hasil : ${result.emailUser}");
        } catch (e) {
          debugPrint(e.toString());
        }
      });
    });

    group("getAllFriend", () {
      test("If Success", () async {
        try {
          await userApi.getAllFriend();
        } catch (e, stackTrace) {
          debugPrint("error getAllFriend $e $stackTrace");
        }
      });
    });

    group("searchSpecificUser", () {
      test("If Success", () async {
        try {
          await userApi.searchSpecificUser("mahen");
        } catch (e, stackTrace) {
          debugPrint("error searchSpecificUser $e $stackTrace");
        }
      });
    });

    group("changeFriendStatus", () {
      test("If Success", () async {
        try {
          await userApi.changeFriendStatus("663e2d4833ae485bbd09c222");
        } catch (e, stackTrace) {
          debugPrint("error changeFriendStatus $e $stackTrace");
        }
      });
    });
  });
}
