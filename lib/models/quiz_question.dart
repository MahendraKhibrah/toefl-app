import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:toefl/models/quiz_content.dart';

part 'quiz_question.g.dart';

@JsonSerializable()
class QuizQuestion {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'quiz_id')
  String quizId;
  String question;
  List<QuizContent>? content;

  QuizQuestion({
    required this.id,
    required this.quizId,
    required this.question,
    required this.content,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuizQuestionToJson(this);

  factory QuizQuestion.fromJsonString(String jsonString) =>
      _$QuizQuestionFromJson(json.decode(jsonString));
  String toJsonString() => json.encode(toJson());
}
