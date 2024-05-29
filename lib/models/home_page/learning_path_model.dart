// To parse this JSON data, do
//
//     final learningPathModel = learningPathModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'learning_path_model.g.dart';


@JsonSerializable()
class LearningPathModel {
    @JsonKey(name: "quiz_type_id")
    String quizTypeId;
    @JsonKey(name: "quiz_type_name")
    String quizTypeName;
    @JsonKey(name: "quiz_count")
    int quizCount;

    LearningPathModel({
        required this.quizTypeId,
        required this.quizTypeName,
        required this.quizCount,
    });

    LearningPathModel copyWith({
        String? quizTypeId,
        String? quizTypeName,
        int? quizCount,
    }) => 
        LearningPathModel(
            quizTypeId: quizTypeId ?? this.quizTypeId,
            quizTypeName: quizTypeName ?? this.quizTypeName,
            quizCount: quizCount ?? this.quizCount,
        );

    factory LearningPathModel.fromJson(Map<String, dynamic> json) => _$LearningPathModelFromJson(json);

    Map<String, dynamic> toJson() => _$LearningPathModelToJson(this);
}
