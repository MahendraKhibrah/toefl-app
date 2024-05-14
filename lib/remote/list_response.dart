import 'dart:convert';

class ListResponse<T> {
  int? code;
  String? message;
  T? data;

  ListResponse({
    this.code,
    this.message,
    this.data,
  });

  factory ListResponse.fromRawJson(
          String str, T Function(Object? json) fromJsonT) =>
      ListResponse.fromJson(json.decode(str), fromJsonT);

  @override
  String toString() => toRawJson();

  String toRawJson() => json.encode(toJson((value) => value));

  factory ListResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      ListResponse(
        code: json['code'],
        message: json['message'],
        data: json['data'] == null ? null : fromJsonT(json['data']),
      );

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => {
        'code': code,
        'message': message,
        'data': data == null ? null : toJsonT(data!),
      };
}
