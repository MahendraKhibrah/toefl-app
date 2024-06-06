import 'package:json_annotation/json_annotation.dart';

part 'game_history.g.dart';

@JsonSerializable()
class GameHistory {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "game_name")
  String? gameName;
  @JsonKey(name: "game_type")
  String? gameType;
  @JsonKey(name: "score")
  double? score;

  GameHistory({
    this.id,
    this.userId,
    this.gameName,
    this.gameType,
    this.score,
  });

  factory GameHistory.fromJson(Map<String, dynamic> json) =>
      _$GameHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$GameHistoryToJson(this);
}
