import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../shared_preference_keys.dart';

class AuthSharedPreference {
  Future<String?> getBearerToken() async {
    final pref = await SharedPreferences.getInstance();
    return 'Bearer ${pref.getString(SharedPreferenceKeys.bearerToken)}';
  }

  FutureOr<void> saveBearerToken(String bearerToken) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(
      SharedPreferenceKeys.bearerToken,
      bearerToken,
    );
  }

  FutureOr<void> removeBearerToken() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(SharedPreferenceKeys.bearerToken);
  }
}
