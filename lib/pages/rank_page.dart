import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toefl/models/leader_board.dart';
import 'package:toefl/remote/api/leader_board_api.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/rank_page/list_rank.dart';
import 'package:toefl/widgets/rank_page/profile_rank.dart';
import 'dart:math' as math;

class RankPage extends StatefulWidget {
  RankPage({super.key});

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  final leaderBoardApi = LeaderBoardApi();
  List<LeaderBoard> leaderBoardEntries = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchLeaderBoard();
  }

  void fetchLeaderBoard() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<LeaderBoard> temp = await leaderBoardApi.getLeaderBoardEntries();
      setState(() {
        leaderBoardEntries = temp;
      });
    } catch (e) {
      print("Error in fetchLeaderBoard: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
        body: Skeletonizer(
            enabled: isLoading,
            child: Skeleton.leaf(
              child: Stack(
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
                            "Score TOEFL Practice Rank Board",
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
                                  name: leaderBoardEntries.length > 1
                                      ? leaderBoardEntries[1].nama
                                      : "",
                                  score: leaderBoardEntries.length > 1
                                      ? leaderBoardEntries[1].totalScore
                                      : 0,
                                  category: "Silver",
                                  rank: 2,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ProfileRank(
                                name: leaderBoardEntries.isNotEmpty
                                    ? leaderBoardEntries[0].nama
                                    : "",
                                score: leaderBoardEntries.isNotEmpty
                                    ? leaderBoardEntries[0].totalScore
                                    : 0,
                                category: "Gold",
                                rank: 1,
                              ),
                            ),
                            Expanded(
                              child: Transform.translate(
                                offset: const Offset(0, 80),
                                child: ProfileRank(
                                  name: leaderBoardEntries.length > 2
                                      ? leaderBoardEntries[2].nama
                                      : "",
                                  score: leaderBoardEntries.length > 2
                                      ? leaderBoardEntries[2].gameScore
                                      : 0,
                                  category: "Bronze",
                                  rank: 3,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 170),
                        Expanded(
                          child: ListView.builder(
                            itemCount:
                                math.max(0, leaderBoardEntries.length - 3),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListRank(
                                  index: index + 4,
                                  name: leaderBoardEntries[index + 3].nama,
                                  score:
                                      leaderBoardEntries[index + 3].totalScore,
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
            )));
  }
}
