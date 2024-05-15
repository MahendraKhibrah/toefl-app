import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:toefl/models/quiz.dart';
import 'package:toefl/utils/utils.dart';

part 'game_data.g.dart';

GameData gameDataFromJson(String str) => GameData.fromJson(json.decode(str));

String gameDataToJson(GameData data) => json.encode(data.toJson());

@JsonSerializable()
class GameData {
  @JsonKey(name: "data")
  List<Game> data;

  GameData({
    required this.data,
  });

  factory GameData.fromJson(Map<String, dynamic> json) =>
      _$GameDataFromJson(json);

  Map<String, dynamic> toJson() => _$GameDataToJson(this);
}

@JsonSerializable()
class Game {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "level")
  int level;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "game_list")
  List<GameList>? gameList;

  Game({
    required this.id,
    required this.level,
    required this.title,
    required this.description,
    required this.gameList,
  });

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  factory Game.fromJsonString(String jsonString) =>
      _$GameFromJson(Utils.stringToJson(jsonString));

  Map<String, dynamic> toJson() => _$GameToJson(this);
  String toStringJson() => toJson().toString();
}

@JsonSerializable()
class GameList {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "game_id")
  String gameId;
  @JsonKey(name: "quiz_id")
  String quizId;
  @JsonKey(name: "quiz")
  Quiz quiz;

  GameList({
    required this.id,
    required this.gameId,
    required this.quizId,
    required this.quiz,
  });

  factory GameList.fromJson(Map<String, dynamic> json) =>
      _$GameListFromJson(json);
  factory GameList.fromJsonString(String jsonString) =>
      _$GameListFromJson(Utils.stringToJson(jsonString));
  Map<String, dynamic> toJson() => _$GameListToJson(this);
  String toStringJson() => toJson().toString();
}
