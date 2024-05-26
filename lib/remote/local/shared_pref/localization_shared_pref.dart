import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../shared_preference_keys.dart';

class LocalizationSharedPreference {
  Future<String?> getSelectedLang() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(SharedPreferenceKeys.selectedLanguage);
  }

  FutureOr<void> saveSelectedLang(String language) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(
      SharedPreferenceKeys.selectedLanguage,
      language,
    );
  }

  FutureOr<void> removeSelectedLang() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(SharedPreferenceKeys.selectedLanguage);
  }
}
