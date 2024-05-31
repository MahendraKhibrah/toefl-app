import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  final String id;
  final String level;
  @JsonKey(name: 'current_score')
  int currentScore;
  @JsonKey(name: 'target_score')
  int targetScore;
  @JsonKey(name: 'name_user')
  final String nameUser;
  @JsonKey(name: 'email_user')
  final String emailUser;

  Profile({
    required this.id,
    required this.level,
    required this.currentScore,
    required this.targetScore,
    required this.nameUser,
    required this.emailUser,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  factory Profile.fromJsonString(String jsonString) =>
      _$ProfileFromJson(jsonDecode(jsonString));

  Map<String, dynamic> _toJson() => _$ProfileToJson(this);

  String toStringJson() => _toJson().toString();
}
