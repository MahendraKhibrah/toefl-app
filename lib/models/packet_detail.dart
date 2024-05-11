import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'packet_detail.g.dart';

@JsonSerializable()
class PacketDetail {
  final String id;
  @JsonKey(name: 'name_packet')
  final String name;

  final List<Question> questions;

  PacketDetail({
    required this.id,
    required this.name,
    required this.questions,
  });

  factory PacketDetail.fromJson(Map<String, dynamic> json) =>
      _$PacketDetailFromJson(json);

  factory PacketDetail.fromJsonString(String jsonString) =>
      _$PacketDetailFromJson(jsonDecode(jsonString));

  Map<String, dynamic> toJson() => _$PacketDetailToJson(this);

  String toStringJson() => toJson().toString();
}

@JsonSerializable()
class Question {
  @JsonKey(defaultValue: '')
  final String id;
  @JsonKey(defaultValue: '')
  final String question;
  @JsonKey(name: 'type_question', defaultValue: '')
  final String typeQuestion;
  @JsonKey(name: 'nested_question_id', defaultValue: '')
  final String nestedQuestionId;
  @JsonKey(name: 'multiple_choices', defaultValue: [])
  final List<Choice> choices;

  Question({
    required this.id,
    required this.question,
    required this.typeQuestion,
    required this.nestedQuestionId,
    required this.choices,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  factory Question.fromJsonString(String jsonString) =>
      _$QuestionFromJson(jsonDecode(jsonString));

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  String toStringJson() => toJson().toString();
}

@JsonSerializable()
class Choice {
  final String id;
  final String choice;

  Choice({
    required this.id,
    required this.choice,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);

  factory Choice.fromJsonString(String jsonString) =>
      _$ChoiceFromJson(jsonDecode(jsonString));

  Map<String, dynamic> toJson() => _$ChoiceToJson(this);

  String toStringJson() => toJson().toString();
}
