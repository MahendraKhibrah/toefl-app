import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_container.dart';
import 'package:toefl/widgets/common_app_bar.dart';

import 'package:toefl/widgets/profile_page/level_score.dart';
import 'package:toefl/widgets/profile_page/profile_name_section.dart';
import 'package:toefl/widgets/profile_page/settings.dart';

import '../../routes/route_key.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // listenToNotification();
    super.initState();
  }

  // listenToNotification() {
  //   print("Listening to notification");
  //   NotificationHelper.onClickNotification.stream.listen((event) {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => HomePage()));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Colors.white,
            appBar: CommonAppBar(
              title: 'appbar_profile'.tr(),
              withBack: false,
            ),
            body: ListView(
              primary: false,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            children: <Widget>[
                              // <<<<<<< adam-notifikasi
                              //                   const Profile(),
                              //                   const SizedBox(
                              //                     height: 20,
                              //                   ),
                              //                   const LevelScore(),
                              //                   const SizedBox(
                              // =======
                              const ProfileNameSection(),
                              const SizedBox(
                                height: 20,
                              ),
                              buildProfileStatus(context),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Text("Game History",
                                        style: CustomTextStyle.bold16.copyWith(
                                          fontSize: 18,
                                        )),
                                  ),
                                  const Spacer(),
                                ],
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
                        buildGameHistorySection(context)
                      ],
                    ),
                  ),
                ),
              ],
            )),
        Positioned(
          top: 52,
          right: 12,
          width: 40,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteKey.settingPage);
            },
            child: BlueContainer(
              padding: 4,
              borderRadius: 10,
              child: Icon(
                Icons.settings,
                color: HexColor(mariner800),
              ),
            ),
          ),
        ),
      ],
    );
  }

  SingleChildScrollView buildGameHistorySection(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(
            width: 24,
          ),
          ...List.generate(
            5,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: BlueContainer(
                width: MediaQuery.of(context).size.width * 0.35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlueContainer(
                      color: mariner700,
                      width: 55,
                      height: 55,
                      padding: 10,
                      child: Center(
                          child: Text(
                        "5",
                        style: CustomTextStyle.extrabold20
                            .copyWith(color: Colors.white),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 2),
                      child: Text(
                        "Challange",
                        style: CustomTextStyle.medium14
                            .copyWith(fontSize: 11, color: HexColor(neutral60)),
                      ),
                    ),
                    Text(
                      "Synonym Pairing hahaha",
                      style: CustomTextStyle.bold16.copyWith(
                        color: HexColor(neutral90),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 24,
          ),
        ],
      ),
    );
  }

  BlueContainer buildProfileStatus(BuildContext context) {
    return BlueContainer(
      padding: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...List.generate(
                  3,
                  (index) => ProfileStatusCard(
                    width: MediaQuery.of(context).size.width * 0.3 - 25,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlueContainer(
                  width: MediaQuery.of(context).size.width * 0.7 - 25,
                  color: mariner700,
                  padding: 12,
                  child: Center(
                    child: Text(
                      "Find a Friend",
                      style: CustomTextStyle.bold16.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                BlueContainer(
                  padding: 12,
                  width: MediaQuery.of(context).size.width * 0.2 - 25,
                  color: mariner700,
                  child: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileStatusCard extends StatelessWidget {
  final double width;

  const ProfileStatusCard({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 155,
      child: Stack(
        children: [
          BlueContainer(
            color: neutral10,
            width: width,
            borderRadius: 7,
            child: Transform.translate(
                offset: const Offset(0, -15),
                child: Text(
                  "Take a Test",
                  style: CustomTextStyle.bold12.copyWith(
                    color: HexColor(mariner900),
                    fontWeight: FontWeight.w900,
                  ),
                )),
          ),
          Positioned(
            top: 20,
            child: BlueContainer(
              height: 130,
              color: mariner500,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "LEVEL",
                        style: CustomTextStyle.extrabold24.copyWith(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Special Advance",
                    style: CustomTextStyle.bold16.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      color: HexColor(mariner600),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Text(
                        "Set Target",
                        style: GoogleFonts.nunito(
                            color: Colors.white, fontSize: 8),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
