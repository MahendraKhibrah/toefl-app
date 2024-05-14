import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:toefl/models/quiz_answer_key.dart';
import 'package:toefl/models/quiz_option.dart';

part 'quiz_content.g.dart';

@JsonSerializable()
class QuizContent {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'quiz_question_id')
  String quizQuestionId;
  String content;
  List<QuizOption> options;
  @JsonKey(name: 'answer_key')
  QuizAnswerKey answerKey;

  QuizContent({
    required this.id,
    required this.quizQuestionId,
    required this.content,
    required this.options,
    required this.answerKey,
  });

  factory QuizContent.fromJson(Map<String, dynamic> json) =>
      _$QuizContentFromJson(json);
  Map<String, dynamic> toJson() => _$QuizContentToJson(this);

  factory QuizContent.fromJsonString(String jsonString) =>
      _$QuizContentFromJson(json.decode(jsonString));
  String toJsonString() => json.encode(toJson());
}
