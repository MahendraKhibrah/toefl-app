import 'dart:convert';

import 'package:flutter/material.dart';
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
  @JsonKey(defaultValue: '', name: 'nama_packet')
  final String packetName;

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
    required this.packetName,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    try {
      return _$AnswerFromJson(json);
    } catch (e, stacktrace) {
      debugPrint('Error Answer Model: $e');
      debugPrint('Stacktrace Answer Model: $stacktrace');
      return Answer(
        id: '',
        question: '',
        keyQuestion: '',
        typeQuestion: '',
        isCorrect: false,
        userAnswer: '',
        nestedQuestionId: '',
        nestedQuestion: '',
        choices: [],
        bookmark: false,
        packetName: '',
      );
    }
  }

  factory Answer.fromJsonString(String jsonString) =>
      _$AnswerFromJson(jsonDecode(jsonString));

  Map<String, dynamic> toJson() => _$AnswerToJson(this);

  String toStringJson() => jsonEncode(toJson());
}
