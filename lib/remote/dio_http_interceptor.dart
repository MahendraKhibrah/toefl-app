import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toefl/routes/route_key.dart';

import '../routes/navigator_key.dart';

class DioHttpInterceptor extends Interceptor {
  // final AuthSharedPreference _authSharedPreference;

  DioHttpInterceptor(/* this._authSharedPreference */);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['device'] = Platform.isAndroid ? 'Android' : 'iOS';
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    //TODO : add bearer token
    options.headers['Authorization'] =
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbG9rYWJlc3RhcmkubGl2ZS9hcGkvbG9naW4iLCJpYXQiOjE3MTUyNjczMzksImV4cCI6MTcxNTI3MDkzOSwibmJmIjoxNzE1MjY3MzM5LCJqdGkiOiJjZXFCOHVlT2M0Unp0TUg2Iiwic3ViIjoiNjYzY2NhOWY5ZjUxZTZjYWU2MDI0OTQyIiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.HFMx01OVX1WLoK5clgmO54Otnjo1ooFr1cajp3IEUjI";
    // await _authSharedPreference.getBearerToken();

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
      //TODO : handle 401
      // final sharedPreference = await SharedPreferences.getInstance();
      // sharedPreference.clear();

      final context = navigatorKey.currentState?.overlay?.context;

      if (context != null && context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          // RouteKey.login,
          RouteKey.root,
          (route) => false,
        );
      }
    }

    super.onError(err, handler);
  }
}
