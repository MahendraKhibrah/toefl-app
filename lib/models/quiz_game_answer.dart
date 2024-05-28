import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_game_answer.g.dart';

@JsonSerializable()
class QuizGameAnswer {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "user_id")
  String userId;
  @JsonKey(name: "quiz_option_id")
  String quizOptionId;
  @JsonKey(name: "quiz_content_id")
  String quizContentId;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "score")
  int score;

  QuizGameAnswer({
    required this.id,
    required this.userId,
    required this.quizOptionId,
    required this.quizContentId,
    required this.createdAt,
    required this.score,
  });

  factory QuizGameAnswer.fromJson(Map<String, dynamic> json) =>
      _$QuizGameAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$QuizGameAnswerToJson(this);
}
