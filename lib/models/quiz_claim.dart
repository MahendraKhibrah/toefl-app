// import 'dart:convert';

// import 'package:json_annotation/json_annotation.dart';
// import 'package:toefl/models/quiz_option.dart';

// part 'quiz_claim.g.dart';

// @JsonSerializable()
// class QuizAnswerKey {
//   @JsonKey(name: '_id')
//   String id;
//   @JsonKey(name: 'quiz_content_id')
//   String quizContentId;
//   @JsonKey(name: 'quiz_option_id')
//   String quizOptionId;
//   String explanation;
//   QuizOption option;

//   QuizAnswerKey({
//     required this.id,
//     required this.quizContentId,
//     required this.quizOptionId,
//     required this.explanation,
//     required this.option,
//   });

//   factory QuizAnswerKey.fromJson(Map<String, dynamic> json) =>
//       _$QuizAnswerKeyFromJson(json);
//   Map<String, dynamic> toJson() => _$QuizAnswerKeyToJson(this);

//   factory QuizAnswerKey.fromJsonString(String jsonString) =>
//       _$QuizAnswerKeyFromJson(json.decode(jsonString));
//   String toJsonString() => json.encode(toJson());
// }
