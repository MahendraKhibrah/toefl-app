import 'package:json_annotation/json_annotation.dart';
part 'quiz_game_result.g.dart';

@JsonSerializable()
class QuizGameResult {
  @JsonKey(name: "total")
  int total;
  @JsonKey(name: "benar")
  int benar;
  @JsonKey(name: "score")
  int score;

  QuizGameResult({
    required this.total,
    required this.benar,
    required this.score,
  });

  factory QuizGameResult.fromJson(Map<String, dynamic> json) =>
      _$QuizGameResultFromJson(json);

  Map<String, dynamic> toJson() => _$QuizGameResultToJson(this);
}
