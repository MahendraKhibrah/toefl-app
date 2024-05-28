// import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:toefl/models/quiz.dart';
import 'package:toefl/models/user.dart';
// import 'package:toefl/models/quiz_option.dart';

// part 'quiz_claim.g.dart';

part 'quiz_claim.g.dart';

@JsonSerializable()
class QuizClaim {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "quiz_id")
  String quizId;
  @JsonKey(name: "user_id")
  String userId;
  @JsonKey(name: "user")
  User? user;
  @JsonKey(name: "quiz")
  Quiz? quiz;
  @JsonKey(name: "is_completed")
  bool isCompleted;

  QuizClaim({
    required this.id,
    required this.quizId,
    required this.userId,
    required this.user,
    required this.quiz,
    required this.isCompleted,
  });

  factory QuizClaim.fromJson(Map<String, dynamic> json) =>
      _$QuizClaimFromJson(json);

  Map<String, dynamic> toJson() => _$QuizClaimToJson(this);
}
