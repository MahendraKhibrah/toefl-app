import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'quiz_option.g.dart';

@JsonSerializable()
class QuizOption {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'quiz_content_id')
  String quizContentId;
  String options;

  QuizOption({
    required this.id,
    required this.quizContentId,
    required this.options,
  });

  factory QuizOption.fromJson(Map<String, dynamic> json) =>
      _$QuizOptionFromJson(json);
  Map<String, dynamic> toJson() => _$QuizOptionToJson(this);

  factory QuizOption.fromJsonString(String jsonString) =>
      _$QuizOptionFromJson(json.decode(jsonString));
  String toJsonString() => json.encode(toJson());
}
