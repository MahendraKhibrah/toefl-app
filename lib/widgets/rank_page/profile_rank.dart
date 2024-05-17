import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class ProfileRank extends StatefulWidget {
  final String name;
  final int score;
  final int rank;
  final String category;
  const ProfileRank(
      {super.key,
      required this.name,
      required this.score,
      required this.category,
      required this.rank});

  @override
  State<ProfileRank> createState() => _ProfileRankState();
}

class _ProfileRankState extends State<ProfileRank> {
  late Color medalColor;
  late String medalIcon;

  @override
  void initState() {
    super.initState();
    medalColor = widget.category == "Gold"
        ? HexColor(goldMedal)
        : widget.category == "Silver"
            ? HexColor(silverMedal)
            : widget.category == "Bronze"
                ? HexColor(bronzeMedal)
                : HexColor(neutral10);

    medalIcon = widget.rank == 1
        ? 'assets/images/gold_medal.svg'
        : widget.rank == 2
            ? 'assets/images/silver_medal.svg'
            : widget.rank == 3
                ? 'assets/images/bronze_medal.svg'
                : 'assets/images/bronze_medal.svg';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 105,
                  height: 105,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: medalColor,
                  ),
                ),
                const CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/avatar_profile.png'),
                  radius: 45,
                ),
                Positioned(
                  bottom: -20,
                  child: SvgPicture.asset(
                        medalIcon,
                        width: 50,
                        height: 50,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              widget.name,
              style: TextStyle(
                fontSize: 12,
                color: HexColor(mariner600),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              alignment: Alignment.center,
              width: 65,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                shape: BoxShape.rectangle,
                color: medalColor,
              ),
              child: Text(
                widget.score.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HexColor(neutral10),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
