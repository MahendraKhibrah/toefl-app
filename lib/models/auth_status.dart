import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'auth_status.g.dart';

@JsonSerializable()
class AuthStatus {
  @JsonKey(defaultValue: false, name: 'is_verified_register')
  final bool isVerified;
  @JsonKey(defaultValue: false, name: 'is_success_register')
  final bool isSuccess;

  AuthStatus({required this.isVerified, required this.isSuccess});

  AuthStatus copyWith({
    bool? isVerified,
    bool? isSuccess,
  }) {
    return AuthStatus(
      isVerified: isVerified ?? this.isVerified,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  factory AuthStatus.fromJson(Map<String, dynamic> json) =>
      _$AuthStatusFromJson(json);

  factory AuthStatus.fromJsonString(String jsonString) =>
      _$AuthStatusFromJson(jsonDecode(jsonString));

  Map<String, dynamic> toJson() => _$AuthStatusToJson(this);

  String toStringJson() => jsonEncode(toJson());
}
