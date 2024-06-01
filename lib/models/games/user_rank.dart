import 'package:json_annotation/json_annotation.dart';
import 'package:toefl/models/leader_board.dart';
import 'package:toefl/models/user.dart';

part 'user_rank.g.dart';

@JsonSerializable()
class UserRank {
  String userId;
  @JsonKey(name: "data")
  List<LeaderBoard>? data;

  UserRank({
    required this.userId,
    this.data,
  });

  factory UserRank.fromJson(Map<String, dynamic> json) =>
      _$UserRankFromJson(json);

  Map<String, dynamic> toJson() => _$UserRankToJson(this);
}
