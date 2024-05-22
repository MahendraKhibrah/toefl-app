import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../utils/utils.dart';

part 'packet_detail.g.dart';

@JsonSerializable()
class PacketDetail extends Equatable {
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
      _$PacketDetailFromJson(Utils.stringToJson(jsonString));

  Map<String, dynamic> toJson() => _$PacketDetailToJson(this);

  String toStringJson() => toJson().toString();

  @override
  List<Object?> get props => [id, name, questions];
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
  @JsonKey(defaultValue: '', name: 'nested_question')
  final String bigQuestion;
  @JsonKey(defaultValue: '')
  String answer;
  @JsonKey(defaultValue: 0)
  final int bookmarked;
  @JsonKey(defaultValue: 0)
  final int number;

  Question(
      {required this.id,
      required this.question,
      required this.typeQuestion,
      required this.nestedQuestionId,
      required this.choices,
      required this.bigQuestion,
      required this.answer,
      required this.bookmarked,
      required this.number});

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  factory Question.fromJsonString(String jsonString) =>
      _$QuestionFromJson(Utils.stringToJson(jsonString));

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  String toStringJson() => toJson().toString();
}

@JsonSerializable()
class Choice {
  @JsonKey(defaultValue: '')
  final String id;
  @JsonKey(defaultValue: '')
  final String choice;

  Choice({
    required this.id,
    required this.choice,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);

  factory Choice.fromJsonString(String jsonString) =>
      _$ChoiceFromJson(jsonDecode(jsonString));

  Map<String, dynamic> toJson() => _$ChoiceToJson(this);

  String toStringJson() => jsonEncode(toJson());
}
