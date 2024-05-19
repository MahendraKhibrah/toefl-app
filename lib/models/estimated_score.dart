import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'estimated_score.g.dart';

@JsonSerializable()
class EstimatedScore {
  @JsonKey(name: 'target_user')
  int targetUser;
  @JsonKey(name: 'user_score')
  int userScore;
  @JsonKey(name: 'score_listening')
  int scoreListening;
  @JsonKey(name: 'score_structure')
  int scoreStructure;
  @JsonKey(name: 'score_reading')
  int scoreReading;

  EstimatedScore({
    required this.targetUser,
    required this.userScore,
    required this.scoreListening,
    required this.scoreStructure,
    required this.scoreReading,
  });

  factory EstimatedScore.fromJson(Map<String, dynamic> json) =>
      _$EstimatedScoreFromJson(json);
  Map<String, dynamic> toJson() => _$EstimatedScoreToJson(this);

  factory EstimatedScore.fromJsonString(String jsonString) =>
      _$EstimatedScoreFromJson(json.decode(jsonString));
  String toJsonString() => json.encode(toJson());
}
