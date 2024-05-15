import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../utils/utils.dart';

part 'test_status.g.dart';

@JsonSerializable()
class TestStatus {
  @JsonKey(defaultValue: '')
  final String id;
  @JsonKey(name: 'start_time', defaultValue: '')
  final String startTime;
  @JsonKey(name: 'reset_table', defaultValue: false)
  final bool resetTable;

  TestStatus({
    required this.id,
    required this.startTime,
    required this.resetTable,
  });

  factory TestStatus.fromJson(Map<String, dynamic> json) =>
      _$TestStatusFromJson(json);

  factory TestStatus.fromJsonString(String jsonString) =>
      _$TestStatusFromJson(jsonDecode(jsonString));

  Map<String, dynamic> toJson() => _$TestStatusToJson(this);

  String toStringJson() => jsonEncode(toJson());
}
