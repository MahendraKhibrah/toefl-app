import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:toefl/models/test/test_status.dart';
import 'package:toefl/remote/local/shared_pref/test_shared_preferences.dart';
import 'package:toefl/routes/route_key.dart';

class OpeningLoadingPage extends StatefulWidget {
  const OpeningLoadingPage({super.key, required this.packetId});

  final String packetId;

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
          id: widget.packetId,
          startTime: DateTime.now().toIso8601String(),
          resetTable: true));
    }

    await Future.delayed(const Duration(seconds: 4));

    final diff = DateTime.now().difference(startDate);
    if (!mounted) {
      return;
    } else {
      Navigator.pushNamed(
        context,
        RouteKey.fullTest,
        arguments: diff.inSeconds + 4,
      ).then((value) {
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.network(
            "https://lottie.host/c080fa2a-87c1-4aa5-bb96-084c344dcb9b/keRDXyBfpb.json"),
      ),
    );
  }
}
