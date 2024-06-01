import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toefl/models/profile.dart' as model;
import 'package:toefl/remote/api/profile_api.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/profile_page/profile.dart';

class LevelScore extends StatefulWidget {
  const LevelScore({super.key});

  @override
  State<LevelScore> createState() => _LevelScoreState();
}

class _LevelScoreState extends State<LevelScore> {
  final profileApi = ProfileApi();
  model.Profile? profile;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  void fetchUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      model.Profile temp = await profileApi.getProfile();
      setState(() {
        profile = temp;
      });
    } catch (e) {
      print("Error : $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: HexColor(mariner100),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    children: [
                      Text(
                        'your_level'.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color: HexColor(mariner800)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                          "${profile?.level == '' ? 'Take A Test' : profile?.level}",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: MediaQuery.of(context).size.width * 0.047,
                            color: HexColor(mariner900),
                          ),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
                VerticalDivider(
                  color: HexColor(mariner500),
                  thickness: 2,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    children: [
                      Text(
                        "Special Advance",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color: HexColor(mariner800)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                          "${profile?.currentScore == '' ? '0' : profile?.currentScore}/${profile?.targetScore}",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 25,
                            color: HexColor(mariner900),
                          ),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
                // _content("Your Level", "${profile?.level}", context),
                // VerticalDivider(
                //   color: HexColor(mariner500),
                //   thickness: 2,
                // ),
                // _content("Special Advance",
                //     "${profile?.currentScore}/${profile?.targetScore}", context)
              ],
            ),
          ),
        ));
  }

  // Widget _content(String title, String value, context) {
  //   return (Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 10),
  //     width: MediaQuery.of(context).size.width * 0.4,
  //     child: Column(
  //       children: [
  //         Text(
  //           title,
  //           style: TextStyle(
  //               fontWeight: FontWeight.w600,
  //               fontSize: 10,
  //               color: HexColor(mariner800)),
  //         ),
  //         const SizedBox(
  //           height: 5,
  //         ),
  //         Text(value,
  //             style: TextStyle(
  //               fontWeight: FontWeight.w900,
  //               fontSize: MediaQuery.of(context).size.width * 0.047,
  //               color: HexColor(mariner900),
  //             ),
  //             textAlign: TextAlign.center),
  //       ],
  //     ),
  //   ));
  // }
}
