import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'test_target.g.dart';

@JsonSerializable()
class UserTarget {
  @JsonKey(name: 'selected_target')
  final TestTarget selectedTarget;
  @JsonKey(name: 'all_targets', defaultValue: [])
  final List<TestTarget> allTargets;

  UserTarget({
    required this.selectedTarget,
    required this.allTargets,
  });

  factory UserTarget.fromJson(Map<String, dynamic> json) =>
      _$UserTargetFromJson(json);

  factory UserTarget.fromJsonString(String jsonString) =>
      _$UserTargetFromJson(jsonDecode(jsonString));

  Map<String, dynamic> toJson() => _$UserTargetToJson(this);

  String toStringJson() => jsonEncode(toJson());
}

@JsonSerializable()
class TestTarget {
  @JsonKey(defaultValue: '')
  final String id;
  @JsonKey(name: 'name_level_target', defaultValue: '')
  final String name;
  @JsonKey(name: 'score_target', defaultValue: 0)
  final int score;

  TestTarget({
    required this.id,
    required this.name,
    required this.score,
  });

  factory TestTarget.fromJson(Map<String, dynamic> json) =>
      _$TestTargetFromJson(json);

  factory TestTarget.fromJsonString(String jsonString) =>
      _$TestTargetFromJson(jsonDecode(jsonString));

  Map<String, dynamic> toJson() => _$TestTargetToJson(this);

  String toStringJson() => jsonEncode(toJson());
}
