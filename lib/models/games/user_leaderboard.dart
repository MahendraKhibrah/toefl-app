import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'user_leaderboard.g.dart';

@JsonSerializable()
class UserLeaderBoard {
  String? name;
  int? rank;
  UserLeaderBoard({this.name, this.rank});

  factory UserLeaderBoard.fromJson(Map<String, dynamic> json) =>
      _$UserLeaderBoardFromJson(json);
  Map<String, dynamic> toJson() => _$UserLeaderBoardToJson(this);

  factory UserLeaderBoard.fromJsonString(String jsonString) =>
      _$UserLeaderBoardFromJson(json.decode(jsonString));
  String toJsonString() => json.encode(toJson());
}
