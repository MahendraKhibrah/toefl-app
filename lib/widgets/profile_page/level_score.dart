import 'package:flutter/material.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class LevelScore extends StatelessWidget {
  final String level;
  final String score;
  const LevelScore({super.key, required this.level, required this.score});

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
                _content("Level", level, context),
                VerticalDivider(
                  color: HexColor(mariner500),
                  thickness: 2,
                ),
                _content("Special Advance", score, context)
              ],
            ),
          ),
        ));
  }

  Widget _content(String title, String value, context) {
    return (Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: HexColor(mariner800)),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(value,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 17,
                color: HexColor(mariner900),
              ),
              textAlign: TextAlign.center),
        ],
      ),
    ));
  }
}
