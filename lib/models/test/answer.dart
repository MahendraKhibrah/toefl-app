import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:toefl/models/test/packet_detail.dart';

part 'answer.g.dart';

@JsonSerializable()
class Answer {
  @JsonKey(defaultValue: '', name: 'question_id')
  final String id;
  @JsonKey(defaultValue: '')
  final String question;
  @JsonKey(defaultValue: '', name: 'key_question')
  final String keyQuestion;
  @JsonKey(defaultValue: '', name: 'type_question')
  final String typeQuestion;
  @JsonKey(defaultValue: false, name: 'correct')
  final bool isCorrect;
  @JsonKey(defaultValue: '', name: 'answer_user')
  final String userAnswer;
  @JsonKey(defaultValue: '', name: 'nested_question_id')
  final String nestedQuestionId;
  @JsonKey(defaultValue: '', name: 'nested_question')
  final String nestedQuestion;
  @JsonKey(defaultValue: [], name: 'multiple_choices')
  final List<Choice> choices;
  @JsonKey(defaultValue: false)
  final bool bookmark;

  Answer({
    required this.id,
    required this.question,
    required this.keyQuestion,
    required this.typeQuestion,
    required this.isCorrect,
    required this.userAnswer,
    required this.nestedQuestionId,
    required this.nestedQuestion,
    required this.choices,
    required this.bookmark,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  factory Answer.fromJsonString(String jsonString) =>
      _$AnswerFromJson(jsonDecode(jsonString));

  Map<String, dynamic> toJson() => _$AnswerToJson(this);

  String toStringJson() => jsonEncode(toJson());
}
