import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  final String id;
  final String level;
  @JsonKey(name: 'current_score', defaultValue: 0)
  int currentScore;
  @JsonKey(name: 'target_score', defaultValue: 0)
  int targetScore;
  @JsonKey(name: 'name_user', defaultValue: '')
  final String nameUser;
  @JsonKey(name: 'email_user', defaultValue: '')
  final String emailUser;
  @JsonKey(defaultValue: 0)
  final int rank;
  @JsonKey(name: 'profile_image', defaultValue: '')
  final String profileImage;
  @JsonKey(name: 'is_friend', defaultValue: false)
  final bool isFriend;

  Profile({
    required this.id,
    required this.level,
    required this.currentScore,
    required this.targetScore,
    required this.nameUser,
    required this.emailUser,
    required this.rank,
    required this.profileImage,
    required this.isFriend,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  factory Profile.fromJsonString(String jsonString) =>
      _$ProfileFromJson(jsonDecode(jsonString));

  Map<String, dynamic> _toJson() => _$ProfileToJson(this);

  String toStringJson() => _toJson().toString();

  Profile copyWith({
    bool? isFriend,
  }) {
    return Profile(
      id: id,
      level: level,
      currentScore: currentScore,
      targetScore: targetScore,
      nameUser: nameUser,
      emailUser: emailUser,
      rank: rank,
      profileImage: profileImage,
      isFriend: isFriend ?? this.isFriend,
    );
  }
}
