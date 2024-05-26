import 'package:flutter/material.dart';

import 'package:toefl/widgets/profile_page/level_score.dart';
import 'package:toefl/widgets/profile_page/profile.dart';
import 'package:toefl/widgets/profile_page/settings.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("Profile"),
        ),
        body: ListView(
          primary: false,
          children: const [
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: <Widget>[
                  Profile(),
                  SizedBox(
                    height: 20,
                  ),
                  LevelScore(),
                  SizedBox(
                    height: 20,
                  ),
                  Setting(),
                ],
              ),
            ),
          ],
        ));
  }
}
