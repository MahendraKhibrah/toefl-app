import 'package:dio/dio.dart';
import 'package:toefl/remote/dio_http_interceptor.dart';

class DioToefl {
  DioToefl._();

  static final instance = Dio(
    BaseOptions(
      responseType: ResponseType.plain,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  )..interceptors.add(DioHttpInterceptor());
}
