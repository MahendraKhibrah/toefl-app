import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/rank_page/list_rank.dart';
import 'package:toefl/widgets/rank_page/profile_rank.dart';

class RankPage extends StatefulWidget {
  const RankPage({super.key});

  @override
  State<RankPage> createState() => _RankPageState();
}

class Player {
  final String name;
  final int score;

  Player({required this.name, required this.score});
}

class _RankPageState extends State<RankPage> {
  final List<Player> players = [
    Player(name: 'Shofira Izza Nurrohmah', score: 400),
    Player(name: 'Adam Rasyid', score: 398),
    Player(name: 'Mahendra Khibrah', score: 395),
    Player(name: 'Reza Muktasib', score: 390),
    Player(name: 'Shofira Izza', score: 400),
    Player(name: 'Adam Rasyid', score: 398),
    Player(name: 'Mahendra Khibrah', score: 395),
    Player(name: 'Reza Muktasib', score: 390),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: HexColor(mariner100),
        centerTitle: true,
        leading: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: const Icon(
            Icons.chevron_left_rounded,
            size: 30,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Leaderboard"),
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/bg_rank.svg',
            fit: BoxFit.cover,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Score TOEFL Pratice Rank Board",
                    style: TextStyle(
                      fontSize: 16,
                      color: HexColor(neutral60),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  verticalDirection: VerticalDirection.up,
                  children: <Widget>[
                    Expanded(
                      child: Transform.translate(
                        offset: const Offset(0, 80),
                        child: ProfileRank(
                            name: "Adinda Z",
                            score: 550,
                            category: "Silver",
                            rank: 2),
                      ),
                    ),
                    Expanded(
                      child: ProfileRank(
                          name: "Arsyita D",
                          score: 660,
                          category: "Gold",
                          rank: 1),
                    ),
                    Expanded(
                      child: Transform.translate(
                        offset: const Offset(0, 80),
                        child: ProfileRank(
                          name: "Mayada A",
                          score: 480,
                          category: "Bronze",
                          rank: 3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 170),
                Expanded(
                  child: ListView.builder(
                    itemCount: players.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListRank(
                          index: index + 4,
                          name: players[index].name,
                          score: players[index].score,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
