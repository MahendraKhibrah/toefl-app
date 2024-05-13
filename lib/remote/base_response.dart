import 'dart:convert';

class BaseResponse<T> {
  int? code;
  String? message;
  T? data;

  BaseResponse({
    this.code,
    this.message,
    this.data,
  });

  factory BaseResponse.fromRawJson(String str) =>
      BaseResponse.fromJson(json.decode(str));

  @override
  String toString() => toRawJson();

  String toRawJson() => json.encode(toJson());

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        code: json['code'],
        message: json['message'],
        data: json['data'],
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'data': data,
      };
}
