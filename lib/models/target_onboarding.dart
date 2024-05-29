import 'package:json_annotation/json_annotation.dart';

part 'target_onboarding.g.dart';

@JsonSerializable()
class TargetOnboarding {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "name_level_target")
  String? nameLevelTarget;
  @JsonKey(name: "score_target")
  int? scoreTarget;

  TargetOnboarding({
    this.id,
    this.nameLevelTarget,
    this.scoreTarget,
  });

  factory TargetOnboarding.fromJson(Map<String, dynamic> json) =>
      _$TargetOnboardingFromJson(json);

  Map<String, dynamic> toJson() => _$TargetOnboardingToJson(this);
}
