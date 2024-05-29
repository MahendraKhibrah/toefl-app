import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toefl/pages/games/practice/pairing_game.dart';
import 'package:toefl/pages/games/practice/scrambled_word.dart';
import 'package:toefl/widgets/home_page/try_card.dart';

class FeatureTest extends StatelessWidget {
  const FeatureTest({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
          height: constraint.maxHeight / 1,
          width: constraint.maxWidth / 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PairingGame(),
                  )),
                  child: TryCard(
                    isBgLight: false,
                    title: "Synonim Pairing",
                    subtitle: "A game that contains synonymous words",
                    child: Positioned(
                      bottom: -(constraint.maxWidth / 5),
                        child: SvgPicture.asset(
                      "assets/images/avatar_featured2.svg",width:constraint.maxWidth / 2.8,
                    )),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WordScramblePage(),
                  )),
                  child: TryCard(
                    title: "Word Scramble",
                    subtitle: "Rearrange the letters to form the correct word",
                    child: Positioned(
                      bottom: -(constraint.maxWidth / 5),
                      right: -(constraint.maxWidth / 9),
                        child: SvgPicture.asset(
                      "assets/images/avatar_featured1.svg",width:constraint.maxWidth / 2.6,
                    )),
                  ),
                )
              ],
            ),
          ));
    });
  }
}
