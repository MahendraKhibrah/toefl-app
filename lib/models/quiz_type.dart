import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'quiz_type.g.dart';


@JsonSerializable()
class QuizType {
  @JsonKey(name: '_id')
  String id;
  String name;
  String desc;

  QuizType({
    required this.id,
    required this.name,
    required this.desc,
  });

  factory QuizType.fromJson(Map<String, dynamic> json) => _$QuizTypeFromJson(json);
  Map<String, dynamic> toJson() => _$QuizTypeToJson(this);

  factory QuizType.fromJsonString(String jsonString) =>
      _$QuizTypeFromJson(json.decode(jsonString));
  String toJsonString() => json.encode(toJson());
}
