import 'package:shared_preferences/shared_preferences.dart';
import 'package:toefl/remote/shared_preference_keys.dart';

class OnBoardingSharedPreference {
  Future<bool> isOnInit() async {
    final pref = await SharedPreferences.getInstance();

    return pref.getBool(SharedPreferenceKeys.onBoarding) ?? true;
  }

  Future<void> setOnboardingFalse() async {
    final pref = await SharedPreferences.getInstance();

    pref.setBool(SharedPreferenceKeys.onBoarding, false);
  }
}
