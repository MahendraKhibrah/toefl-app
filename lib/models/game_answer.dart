import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:toefl/models/quiz_option.dart';

part 'game_answer.g.dart';

@JsonSerializable()
class GameAnswer {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'quiz_content_id')
  String quizContentId;
  @JsonKey(name: 'quiz_option_id')
  String quizOptionId;
  @JsonKey(name: 'game_claim_id')
  String gameClaimId;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  double score;
  QuizOption option;

  GameAnswer(
      {required this.id,
      required this.quizContentId,
      required this.quizOptionId,
      required this.gameClaimId,
      required this.option,
      required this.createdAt,
      required this.score});

  factory GameAnswer.fromJson(Map<String, dynamic> json) =>
      _$GameAnswerFromJson(json);
  Map<String, dynamic> toJson() => _$GameAnswerToJson(this);

  factory GameAnswer.fromJsonString(String jsonString) =>
      _$GameAnswerFromJson(json.decode(jsonString));
  String toJsonString() => json.encode(toJson());
}
