import 'package:flutter/material.dart';
import 'package:toefl/widgets/common_app_bar.dart';
import 'package:toefl/widgets/profile_page/settings.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: "Setting",
      ),
      body: Setting(),
    );
  }
}
