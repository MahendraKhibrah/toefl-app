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
                ),
                InkWell(
                  onTap: () => Navigator.of(context)
                      .pushNamed(RouteKey.miniSimulationTest),
                  child: TryCard(
                    title: "Mini Test",
                    icon: "assets/images/pesawat.svg",
                    subtitle: "A test that contains\n70 questions",
                    child: Positioned(
                        bottom: -(constraint.maxWidth / 4.5),
                        right: -(constraint.maxWidth / 8),
                        child: SvgPicture.asset(
                          fit: BoxFit.cover,
                          "assets/images/avatar_featured1.svg",
                          width: constraint.maxWidth / 2.6,
                        )),
                  ),
                )
              ],
            ),
          ));
    });
  }
}
