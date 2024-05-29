import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'regist.g.dart';

@JsonSerializable()
class Regist {
  final String name;
  final String email;
  final String password;
  @JsonKey(name: 'password_confirmation')
  final String passwordConfirmation;
  @JsonKey(name: 'target_id')
  final String targetId;
  Regist(
      {required this.name,
      required this.email,
      required this.password,
      required this.passwordConfirmation,
      required this.targetId});

  factory Regist.fromJson(Map<String, dynamic> json) => _$RegistFromJson(json);

  factory Regist.fromJsonString(String jsonString) =>
      _$RegistFromJson(jsonDecode(jsonString));

  Map<String, dynamic> toJson() => _$RegistToJson(this);

  String toStringJson() => toJson().toString();
}
