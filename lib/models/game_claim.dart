import 'package:json_annotation/json_annotation.dart';
import 'package:toefl/models/quiz.dart';
import 'package:toefl/models/game_data.dart';
import 'package:toefl/models/user.dart';

part 'game_claim.g.dart';

@JsonSerializable()
class GameClaim {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "game_set_id")
  String gameSetId;
  @JsonKey(name: "user_id")
  String userId;
  @JsonKey(name: "user")
  User? user;
  @JsonKey(name: "game_set")
  GameSet? gameSet;
  @JsonKey(name: "is_completed")
  bool isCompleted;

  GameClaim({
    required this.id,
    required this.gameSetId,
    required this.userId,
    required this.user,
    required this.gameSet,
    required this.isCompleted,
  });

  factory GameClaim.fromJson(Map<String, dynamic> json) =>
      _$GameClaimFromJson(json);

  Map<String, dynamic> toJson() => _$GameClaimToJson(this);
}

@JsonSerializable()
class GameSet {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "game_id")
  String gameId;
  @JsonKey(name: "quiz_id")
  String quizId;
  @JsonKey(name: "quiz")
  Quiz? quiz;
  @JsonKey(name: "game")
  Game? game;

  GameSet({
    required this.id,
    required this.gameId,
    required this.quizId,
    required this.quiz,
    required this.game,
  });

  factory GameSet.fromJson(Map<String, dynamic> json) =>
      _$GameSetFromJson(json);

  Map<String, dynamic> toJson() => _$GameSetToJson(this);
}
