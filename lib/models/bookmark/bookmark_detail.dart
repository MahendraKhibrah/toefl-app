import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:toefl/models/test/packet_detail.dart';

part 'bookmark_detail.g.dart';

@JsonSerializable()
class BookmarkDetail {
  @JsonKey(defaultValue: '')
  final String id;
  @JsonKey(defaultValue: '')
  final String question;
  @JsonKey(defaultValue: '', name: 'key_answer')
  final String keyQuestion;
  @JsonKey(defaultValue: false, name: 'correct')
  final bool isCorrect;
  @JsonKey(defaultValue: '', name: 'answer_user')
  final String userAnswer;
  @JsonKey(defaultValue: '', name: 'nested_question')
  final String nestedQuestion;
  @JsonKey(defaultValue: [], name: 'multiple_choices')
  final List<Choice> choices;

  BookmarkDetail({
    required this.id,
    required this.question,
    required this.keyQuestion,
    required this.isCorrect,
    required this.nestedQuestion,
    required this.choices,
    required this.userAnswer,
  });

  factory BookmarkDetail.fromJson(Map<String, dynamic> json) =>
      _$BookmarkDetailFromJson(json);

  factory BookmarkDetail.fromJsonString(String jsonString) =>
      _$BookmarkDetailFromJson(jsonDecode(jsonString));

  Map<String, dynamic> toJson() => _$BookmarkDetailToJson(this);

  String toStringJson() => jsonEncode(toJson());
}
