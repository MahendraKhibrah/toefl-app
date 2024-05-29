import 'package:flutter/material.dart';
import 'package:toefl/pages/games/practice/pairing_game.dart';
import 'package:toefl/pages/games/practice/scrambled_word.dart';
import 'package:toefl/widgets/home_page/try_card.dart';

List<Map<String, dynamic>> feature = [
  {
    "title": "Synonim Pairing",
    "subtitle": "random",
    "onTap": (BuildContext context) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PairingGame(),
      ));
    },
    "isLightBg": false
  },
  {
    "title": "Word Scramble",
    "subtitle": "random",
    "onTap": (BuildContext context) {Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WordScramblePage(),
                ));},
    "isLightBg": true
  },
];

class FeatureTest extends StatelessWidget {
  const FeatureTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      width: double.infinity,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 24),
        separatorBuilder: (context, index) => const SizedBox(
          width: 15,
        ),
        shrinkWrap: true,
        itemCount: feature.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final featured = feature[index];
          return TryCard(
            isBgLight: featured["isLightBg"],
            title: featured["title"],
            subtitle: featured['subtitle'],
            onPressed: featured['onTap'],
          );
        },
      ),
    );
  }
}
