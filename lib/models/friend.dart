import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'friend.g.dart';

@JsonSerializable()
class Friend {
  final String id;
  @JsonKey(name: 'profile_image', defaultValue: '')
  final String profileImage;
  @JsonKey(defaultValue: '')
  final String name;

  Friend({
    required this.id,
    required this.profileImage,
    required this.name,
  });

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);

  factory Friend.fromJsonString(String jsonString) =>
      _$FriendFromJson(jsonDecode(jsonString));

  Map<String, dynamic> _toJson() => _$FriendToJson(this);

  String toStringJson() => _toJson().toString();
}
