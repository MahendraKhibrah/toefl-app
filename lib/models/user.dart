import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String level;
  @JsonKey(name: 'current_score')
  final String currentScore;
  @JsonKey(name: 'target_score')
  final String targetScore;
  @JsonKey(name: 'name_user')
  final String nameUser;
  @JsonKey(name: 'email_user')
  final String emailUser;

  User({
    required this.id,
    required this.level,
    required this.currentScore,
    required this.targetScore,
    required this.nameUser,
    required this.emailUser,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromJsonString(String jsonString) =>
      _$UserFromJson(jsonDecode(jsonString));

  Map<String, dynamic> _toJson() => _$UserToJson(this);

  String toStringJson() => _toJson().toString();
}
