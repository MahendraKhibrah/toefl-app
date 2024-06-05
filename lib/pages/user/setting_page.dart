import 'package:flutter/material.dart';
import 'package:toefl/widgets/common_app_bar.dart';
import 'package:toefl/widgets/profile_page/settings.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key, required this.name, required this.image});

  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        title: "Setting",
      ),
      body: Setting(
        name: name,
        image: image,
      ),
    );
  }
}
