import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:toefl/models/test/test_status.dart';
import 'package:toefl/remote/local/shared_pref/test_shared_preferences.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/state_management/full_test_provider.dart';

class OpeningLoadingPage extends ConsumerStatefulWidget {
  const OpeningLoadingPage(
      {super.key, required this.packetId, required this.isRetake});

  final String packetId;
  final bool isRetake;

  @override
  ConsumerState<OpeningLoadingPage> createState() => _OpeningLoadingPageState();
}

class _OpeningLoadingPageState extends ConsumerState<OpeningLoadingPage> {
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
    await ref.read(fullTestProvider.notifier).onInit();
    await Future.delayed(const Duration(seconds: 4));

    final diff = DateTime.now().difference(startDate);
    if (!mounted) {
      return;
    } else {
      Navigator.pushNamed(
        context,
        RouteKey.fullTest,
        arguments: {
          "diffInSeconds": diff.inSeconds + 4,
          "isRetake": widget.isRetake,
        },
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
