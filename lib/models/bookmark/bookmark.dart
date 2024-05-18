import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'bookmark.g.dart';

@JsonSerializable()
class Bookmark {
  @JsonKey(defaultValue: '')
  final String id;
  @JsonKey(defaultValue: '')
  final String question;

  Bookmark({
    required this.id,
    required this.question,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) =>
      _$BookmarkFromJson(json);

  factory Bookmark.fromJsonString(String jsonString) =>
      _$BookmarkFromJson(jsonDecode(jsonString));

  Map<String, dynamic> toJson() => _$BookmarkToJson(this);

  String toStringJson() => jsonEncode(toJson());
}
