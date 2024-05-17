import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  @JsonKey(defaultValue: '')
  final String id;
  @JsonKey(defaultValue: 0, name: 'score')
  final int precentage;
  @JsonKey(defaultValue: 0, name: 'score_toefl')
  final int toeflScore;
  @JsonKey(defaultValue: 0, name: 'correct_question_all')
  final int correctQuestionAll;
  @JsonKey(defaultValue: 0, name: 'total_question_all')
  final int totalQuestionAll;
  @JsonKey(defaultValue: 0, name: 'correct_question_listening_all')
  final int correctListeningAll;
  @JsonKey(defaultValue: 0, name: 'total_question_listening_all')
  final int totalListeningAll;
  @JsonKey(defaultValue: 0, name: 'listening_part_a_correct')
  final int listeningPartACorrect;
  @JsonKey(defaultValue: 0, name: 'total_question_listening_part_a')
  final int totalListeningPartA;
  @JsonKey(defaultValue: 0, name: 'accuracy_listening_part_a')
  final int accuracyListeningPartA;
  @JsonKey(defaultValue: 0, name: 'correct_question_listening_part_b')
  final int correctListeningPartB;
  @JsonKey(defaultValue: 0, name: 'total_question_listening_part_b')
  final int totalListeningPartB;
  @JsonKey(defaultValue: 0, name: 'accuracy_listening_part_b')
  final int accuracyListeningPartB;
  @JsonKey(defaultValue: 0, name: 'correct_question_listening_part_c')
  final int correctListeningPartC;
  @JsonKey(defaultValue: 0, name: 'total_question_listening_part_c')
  final int totalListeningPartC;
  @JsonKey(defaultValue: 0, name: 'accuracy_listening_part_c')
  final int accuracyListeningPartC;
  @JsonKey(defaultValue: 0, name: 'correct_question_structure_all')
  final int correctStructureAll;
  @JsonKey(defaultValue: 0, name: 'total_question_structure_all')
  final int totalStructureAll;
  @JsonKey(defaultValue: 0, name: 'correct_question_structure_part_a')
  final int correctStructurePartA;
  @JsonKey(defaultValue: 0, name: 'total_question_structure_part_a')
  final int totalStructurePartA;
  @JsonKey(defaultValue: 0, name: 'accuracy_structure_part_a')
  final int accuracyStructurePartA;
  @JsonKey(defaultValue: 0, name: 'correct_question_structure_part_b')
  final int correctStructurePartB;
  @JsonKey(defaultValue: 0, name: 'total_question_structure_part_b')
  final int totalStructurePartB;
  @JsonKey(defaultValue: 0, name: 'accuracy_structure_part_b')
  final int accuracyStructurePartB;
  @JsonKey(defaultValue: 0, name: 'correct_question_reading')
  final int correctReading;
  @JsonKey(defaultValue: 0, name: 'total_question_reading')
  final int totalReading;
  @JsonKey(defaultValue: 0, name: 'accuracy_reading')
  final int accuracyReading;

  Result({
    required this.id,
    required this.precentage,
    required this.toeflScore,
    required this.correctQuestionAll,
    required this.totalQuestionAll,
    required this.correctListeningAll,
    required this.totalListeningAll,
    required this.listeningPartACorrect,
    required this.totalListeningPartA,
    required this.accuracyListeningPartA,
    required this.correctListeningPartB,
    required this.totalListeningPartB,
    required this.accuracyListeningPartB,
    required this.correctListeningPartC,
    required this.totalListeningPartC,
    required this.accuracyListeningPartC,
    required this.correctStructureAll,
    required this.totalStructureAll,
    required this.correctStructurePartA,
    required this.totalStructurePartA,
    required this.accuracyStructurePartA,
    required this.correctStructurePartB,
    required this.totalStructurePartB,
    required this.accuracyStructurePartB,
    required this.correctReading,
    required this.totalReading,
    required this.accuracyReading,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  factory Result.fromJsonString(String jsonString) =>
      _$ResultFromJson(jsonDecode(jsonString));

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  String toStringJson() => jsonEncode(toJson());
}
