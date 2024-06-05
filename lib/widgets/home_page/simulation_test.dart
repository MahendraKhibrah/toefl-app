import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';
import 'package:toefl/pages/games/practice/pairing_game.dart';
import 'package:toefl/pages/games/practice/scrambled_word.dart';
import 'package:toefl/routes/navigator_key.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/home_page/try_card.dart';

class SimulationTestWidget extends StatelessWidget {
  SimulationTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
          height: MediaQuery.of(context).size.height / 5,
          width: constraint.maxWidth / 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () =>
                      Navigator.of(context).pushNamed(RouteKey.simulationpage),
                  child: TryCard(
                    isBgLight: false,
                    title: "Full Test",
                    icon: "assets/images/medali.svg",
                    subtitle: "A test that contains\n140 questions",
                    child: Positioned(
                        bottom: -(constraint.maxWidth / 4.5),
                        child: SvgPicture.asset(
                          fit: BoxFit.contain,
                          "assets/images/avatar_featured2.svg",
                          width: constraint.maxWidth / 2.8,
                        )),
                  ),
                  Positioned(
                      top: (constraint.maxHeight / 10),
                      right: (index == 0)
                          ? (constraint.maxHeight / 3.5)
                          : (constraint.maxHeight / 2.8),
                      child: SvgPicture.asset(
                        topic["icon"],
                        color: (index == 0)
                            ? HexColor("#76B7E4")
                            : HexColor(mariner100),
                        height: constraint.maxHeight / 8,
                      )),
                  Positioned(
                    top: (constraint.maxHeight / 4),
                    left: (constraint.maxHeight / 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'test_description'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: constraint.maxHeight / 16,
                              fontWeight: FontWeight.w800,
                              color: (index == 0)
                                  ? HexColor(mariner900)
                                  : HexColor(neutral10)),
                        ),
                        Text(
                          topic["subtitle"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: constraint.maxHeight / 16,
                              fontWeight: FontWeight.w800,
                              color: (index == 0)
                                  ? HexColor(mariner900)
                                  : HexColor(neutral10)),
                        ),
                      ],
                    ),

                  ),
                  Positioned(
                      right: -(constraint.maxHeight / 70),
                      top: (constraint.maxHeight / 16),
                      child: SvgPicture.asset(
                        "assets/images/vector_bg_st.svg",
                        color: (index == 0)
                            ? HexColor("#76B7E4")
                            : HexColor(mariner100),
                        width: constraint.maxHeight / 1,
                      )),
                  Positioned(
                      bottom: constraint.maxHeight / 12,
                      right: (constraint.maxHeight / 18),
                      child: SizedBox(
                        height: constraint.maxHeight / 5,
                        width: constraint.maxHeight / 1.8,
                        child: TextButton(
                            onPressed: topic["onTap"],
                            child: Text(
                              'try'.tr(),
                              style: TextStyle(
                                  fontSize: constraint.maxHeight / 14,
                                  fontWeight: FontWeight.w800,
                                  color: HexColor(mariner900)),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  HexColor(topic["color"])),
                            )),
                      ))
                ],
              );
            },

          );
        },
      ),
    );
  }
}
