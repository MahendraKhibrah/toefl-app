import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/test/test_status.dart';
import '../../shared_preference_keys.dart';

class TestSharedPreference {
  Future<TestStatus?> getStatus() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString(SharedPreferenceKeys.finalTestStatus);
    if (data != null) {
      return TestStatus.fromJsonString(data);
    } else {
      return null;
    }
  }

  FutureOr<void> saveStatus(TestStatus status) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(
      SharedPreferenceKeys.finalTestStatus,
      status.toStringJson(),
    );
  }

  FutureOr<void> removeStatus() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(SharedPreferenceKeys.finalTestStatus);
  }

  Future<TestStatus?> getMiniStatus() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString(SharedPreferenceKeys.miniTestStatus);
    if (data != null) {
      return TestStatus.fromJsonString(data);
    } else {
      return null;
    }
  }

  FutureOr<void> saveMiniStatus(TestStatus status) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(
      SharedPreferenceKeys.miniTestStatus,
      status.toStringJson(),
    );
  }

  FutureOr<void> removeMiniStatus() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(SharedPreferenceKeys.miniTestStatus);
  }
}
