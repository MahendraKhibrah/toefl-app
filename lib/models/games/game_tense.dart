import 'package:json_annotation/json_annotation.dart';
import 'package:toefl/models/word_synonym.dart';

part 'game_tense.g.dart';

@JsonSerializable()
class GameTense {
    @JsonKey(name: "_id")
    Id? id;
    @JsonKey(name: "sentence")
    String? sentence;
    @JsonKey(name: "tense")
    String? tense;

    GameTense({
        this.id,
        this.sentence,
        this.tense,
    });

    factory GameTense.fromJson(Map<String, dynamic> json) => _$GameTenseFromJson(json);

    Map<String, dynamic> toJson() => _$GameTenseToJson(this);
}
