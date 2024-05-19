import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:toefl/models/quiz_option.dart';

part 'quiz_answer.g.dart';

@JsonSerializable()
class QuizAnswer {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'quiz_content_id')
  String quizContentId;
  @JsonKey(name: 'quiz_option_id')
  String quizOptionId;
  @JsonKey(name: 'quiz_claim_id')
  String quizClaimId;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  double score;
  QuizOption option;

  QuizAnswer(
      {required this.id,
      required this.quizContentId,
      required this.quizOptionId,
      required this.quizClaimId,
      required this.option,
      required this.createdAt,
      required this.score});

  factory QuizAnswer.fromJson(Map<String, dynamic> json) =>
      _$QuizAnswerFromJson(json);
  Map<String, dynamic> toJson() => _$QuizAnswerToJson(this);

  factory QuizAnswer.fromJsonString(String jsonString) =>
      _$QuizAnswerFromJson(json.decode(jsonString));
  String toJsonString() => json.encode(toJson());
}
