import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'packet.g.dart';

@JsonSerializable()
class Packet {
  @JsonKey(defaultValue: '')
  final String id;
  @JsonKey(name: 'name_packet', defaultValue: '')
  final String name;
  @JsonKey(name: 'akurasi', defaultValue: 0)
  final int accuracy;
  @JsonKey(name: 'question_count', defaultValue: 0)
  final int questionCount;
  @JsonKey(name: 'status_test', defaultValue: false)
  final bool wasFilled;

  Packet({
    required this.id,
    required this.name,
    required this.accuracy,
    required this.questionCount,
    required this.wasFilled,
  });

  factory Packet.fromJson(Map<String, dynamic> json) => _$PacketFromJson(json);

  factory Packet.fromJsonString(String jsonString) =>
      _$PacketFromJson(jsonDecode(jsonString));

  Map<String, dynamic> toJson() => _$PacketToJson(this);

  String toStringJson() => jsonEncode(toJson());
}
