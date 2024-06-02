import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toefl/pages/home_page.dart';
import 'package:toefl/routes/local_notification.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/widgets/common_app_bar.dart';
import 'package:toefl/widgets/profile_page/level_score.dart';
import 'package:toefl/widgets/profile_page/profile_name_section.dart';
import 'package:toefl/widgets/profile_page/settings.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // @override
  // void initState() {
  //   listenToNotification();
  //   super.initState();
  // }

  // listenToNotification() {
  //   NotificationHelper.onClickNotification.stream.listen((event) {
  //     Navigator.popAndPushNamed(context, RouteKey.main);
  //   });
  // }

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
                  SizedBox(
                    height: 20,
                  ),
                  // ElevatedButton.icon(
                  //   onPressed: () {
                  //     LocalNotification.showSimpleNotification(
                  //         title: "Ayo belajar",
                  //         body: "Ini adalah notifikasi reminder",
                  //         payload: "This is simple data");
                  //   },
                  //   icon: const Icon(Icons.notifications_outlined),
                  //   label: const Text("Simple Notifikasi"),
                  // ),
                  // ElevatedButton.icon(
                  //   icon: const Icon(Icons.timer_outlined),
                  //   onPressed: () {
                  //     LocalNotification.showScheduleNotification(
                  //         title: "Ayo belajar toefl",
                  //         body: "Tingkatkan target toefl mu",
                  //         payload: "This is schedule data");
                  //   },
                  //   label: const Text("Reminder Notifikasi"),
                  // )
                ],
              ),
            ),
          ],
        ));
  }
}
