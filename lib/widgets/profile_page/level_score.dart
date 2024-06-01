import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toefl/models/profile.dart' as model;
import 'package:toefl/remote/api/profile_api.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

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
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
                        "Your Level",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color: HexColor(mariner800)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Skeletonizer(
                        enabled: isLoading,
                        child: Skeleton.leaf(
                          child: Text(
                              "${profile?.level == '' ? 'Take a test first' : profile?.level ?? 'Take Your Test'}",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.047,
                                color: HexColor(mariner900),
                              ),
                              textAlign: TextAlign.center),
                        ),
                      ),
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
                      Skeletonizer(
                        enabled: isLoading,
                        child: Skeleton.leaf(
                          child: Text(
                              "${profile?.currentScore == '' ? '0' : profile?.currentScore ?? 0}/${profile?.targetScore ?? 0}",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: MediaQuery.of(context).size.width * 0.055,
                                color: HexColor(mariner900),
                              ),
                              textAlign: TextAlign.center),
                        ),
                      ),
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
