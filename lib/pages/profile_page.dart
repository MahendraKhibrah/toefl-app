import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toefl/widgets/common_app_bar.dart';

import 'package:toefl/widgets/profile_page/level_score.dart';
import 'package:toefl/widgets/profile_page/profile_name_section.dart';
import 'package:toefl/widgets/profile_page/settings.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(
          title: 'appbar_profile'.tr(),
          withBack: false,
        ),
        body: ListView(
          primary: false,
          children: const [
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: <Widget>[
                  ProfileNameSection(),
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
