import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toefl/models/games/user_rank.dart';
import 'package:toefl/models/leader_board.dart';
import 'package:toefl/remote/api/leader_board_api.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/rank_page/list_rank.dart';
import 'package:toefl/widgets/rank_page/profile_rank.dart';
import 'dart:math' as math;

class RankPage extends StatefulWidget {
  final UserRank dataRank;
  const RankPage({super.key, required this.dataRank});

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  late UserRank listRank;
  bool isLoading = false;

  Future<UserRank> refreshData() async {
    if (mounted) {
      isLoading = true;
    }
    UserRank data = await LeaderBoardApi().getLeaderBoardEntries();
    setState(() {
      listRank = data;
    });
    if (mounted) {
      isLoading = false;
    }
    return data;
  }

  @override
  void initState() {
    super.initState();
    listRank = widget.dataRank;
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
          title: Text(
            'Leaderboard',
            style: CustomTextStyle.bold18,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => refreshData(),
          child: Skeletonizer(
              enabled: isLoading,
              child: Skeleton.leaf(
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      'assets/images/bg_rank.svg',
                      fit: BoxFit.fitWidth,
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
                                    name: listRank.data!.length > 1
                                        ? listRank.data![1].nama
                                        : "",
                                    score: listRank.data!.length > 1
                                        ? listRank.data![1].totalScore
                                        : 0,
                                    category: "Silver",
                                    rank: 2,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ProfileRank(
                                  name: listRank.data!.isNotEmpty
                                      ? listRank.data![0].nama
                                      : "",
                                  score: listRank.data!.isNotEmpty
                                      ? listRank.data![0].totalScore
                                      : 0,
                                  category: "Gold",
                                  rank: 1,
                                ),
                              ),
                              Expanded(
                                child: Transform.translate(
                                  offset: const Offset(0, 80),
                                  child: ProfileRank(
                                    name: listRank.data!.length > 2
                                        ? listRank.data![2].nama
                                        : "",
                                    score: listRank.data!.length > 2
                                        ? listRank.data![2].gameScore
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
                              itemCount: math.max(0, listRank.data!.length - 3),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: ListRank(
                                    index: index + 4,
                                    name: listRank.data![index + 3].nama,
                                    score: listRank.data![index + 3].totalScore,
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
              )),
        ));
  }
}
