import 'package:flutter/material.dart';
import 'package:toefl/models/test/test_status.dart';
import 'package:toefl/remote/local/shared_pref/test_shared_preferences.dart';
import 'package:toefl/routes/route_key.dart';

class OpeningLoadingPage extends StatefulWidget {
  const OpeningLoadingPage({super.key});

  @override
  State<OpeningLoadingPage> createState() => _OpeningLoadingPageState();
}

class _OpeningLoadingPageState extends State<OpeningLoadingPage> {
  @override
  void initState() {
    super.initState();
    _onInit();
  }

  Future<void> _onInit() async {
    final TestSharedPreference sharedPref = TestSharedPreference();
    final status = await sharedPref.getStatus();
    DateTime startDate = DateTime.now();
    if (status != null) {
      startDate = DateTime.parse(status.startTime);
    } else {
      await sharedPref.saveStatus(TestStatus(
          id: "66313a811b703e05e00f0c68",
          startTime: DateTime.now().toIso8601String()));
    }

    final diff = DateTime.now().difference(startDate);
    if (!mounted) {
      return;
    } else {
      Navigator.pushReplacementNamed(context, RouteKey.fullTest,
          arguments: diff.inSeconds);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
