import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class Login {
  final String email;
  final String password;

  Login({
    required this.email,
    required this.password,
  });

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  factory Login.fromJsonString(String jsonString) =>
      _$LoginFromJson(jsonDecode(jsonString));

  Map<String, dynamic> toJson() => _$LoginToJson(this);

  String toStringJson() => toJson().toString();
}
