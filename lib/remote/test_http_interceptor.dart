import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toefl/routes/route_key.dart';

import '../routes/navigator_key.dart';

class TestHttpInterceptor extends Interceptor {
  TestHttpInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['device'] = Platform.isAndroid ? 'Android' : 'iOS';
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';

    debugPrint('REQUEST[${options.method}]: ${options.uri}');
    debugPrint('REQUEST HEADERS: ${options.headers}');
    debugPrint('REQUEST DATA: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}]: ${response.requestOptions.uri}');
    debugPrint('RESPONSE HEADERS: ${response.headers}');
    debugPrint('RESPONSE DATA: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;
    final uri = err.requestOptions.uri;
    debugPrint('ERROR[${statusCode ?? 'unknown'}]: $uri');
    debugPrint('ERROR MESSAGE: ${err.message}');

    if (statusCode == 401) {
      final sharedPreference = await SharedPreferences.getInstance();
      sharedPreference.clear();

      final context = navigatorKey.currentState?.overlay?.context;

      if (context != null && context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouteKey.login,
          (route) => false,
        );
      }
    }

    super.onError(err, handler);
  }
}
