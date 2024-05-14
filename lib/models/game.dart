import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:toefl/models/quiz.dart';
import 'package:toefl/models/quiz_type.dart';

part 'game.g.dart';

@JsonSerializable()
class Game {
  @JsonKey(name: '_id')
  String id;
  int level;
  String title;
  String description;
  List<GameList> gameList;

  Game({
    required this.id,
    required this.level,
    required this.title,
    required this.description,
    required this.gameList,
  });

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);
}

@JsonSerializable()
class GameList {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'game_id')
  String gameId;
  @JsonKey(name: 'quiz_id')
  String quizId;
  Quiz quiz;

  GameList({
    required this.id,
    required this.gameId,
    required this.quizId,
    required this.quiz,
  });

  factory GameList.fromJson(Map<String, dynamic> json) => _$GameListFromJson(json);
  Map<String, dynamic> toJson() => _$GameListToJson(this);
}
