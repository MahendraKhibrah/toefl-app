import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:toefl/models/quiz_claim.dart';
import 'package:toefl/models/quiz_question.dart';
import 'package:toefl/models/quiz_type.dart';

part 'quiz.g.dart';

@JsonSerializable()
class Quiz {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'quiz_name')
  String quizName;
  @JsonKey(name: 'quiz_type_id')
  String quizTypeId;
  QuizType type;
  List<QuizQuestion>? questions;
  @JsonKey(name: 'quiz_claim')
  List<QuizClaim>? quizClaim;

  Quiz({
    required this.id,
    required this.quizName,
    required this.quizTypeId,
    required this.type,
    required this.questions,
    this.quizClaim,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
  Map<String, dynamic> _toJson() => _$QuizToJson(this);

  factory Quiz.fromJsonString(String jsonString) =>
      _$QuizFromJson(json.decode(jsonString));
  String toStringJson() => _toJson().toString();
}
