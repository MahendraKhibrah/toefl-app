import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:toefl/models/games/user_leaderboard.dart';

part 'leader_board.g.dart';

@JsonSerializable()
class LeaderBoard {
  @JsonKey(name: 'user_id')
  String userId;
  @JsonKey(name: 'user')
  UserLeaderBoard user;
  @JsonKey(name: 'total_score')
  int totalScore;
  @JsonKey(name: 'game_score')
  int gameScore;
  @JsonKey(name: 'quiz_score')
  int quizScore;

  LeaderBoard({
    required this.userId,
    required this.user,
    required this.totalScore,
    required this.gameScore,
    required this.quizScore,
  });

  factory LeaderBoard.fromJson(Map<String, dynamic> json) =>
      _$LeaderBoardFromJson(json);
  Map<String, dynamic> toJson() => _$LeaderBoardToJson(this);

  factory LeaderBoard.fromJsonString(String jsonString) =>
      _$LeaderBoardFromJson(json.decode(jsonString));
  String toJsonString() => json.encode(toJson());
}
