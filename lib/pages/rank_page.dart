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
import 'package:toefl/widgets/common_app_bar.dart';
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
        appBar: CommonAppBar(
          title: 'Leaderboard',
          backgroundColor: HexColor(mariner100),
        ),
        body: RefreshIndicator(
          onRefresh: () => refreshData(),
          child: Skeletonizer(
              enabled: isLoading,
              child: Skeleton.leaf(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      alignment: Alignment.bottomCenter,
                      child: listRank.data != null
                          ? ListView.builder(
                              itemCount: math.max(0, listRank.data!.length - 3),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: index == 0 ? 90 : 8,
                                      bottom: index ==
                                              math.max(
                                                      0,
                                                      listRank.data!.length -
                                                          3) -
                                                  1
                                          ? 20
                                          : 8,
                                      left: 24,
                                      right: 24),
                                  child: ListRank(
                                    index: index + 4,
                                    name: listRank.data![index + 3].user.name!,
                                    score: listRank.data![index + 3].totalScore,
                                  ),
                                );
                              },
                            )
                          : Padding(
                              padding: EdgeInsets.all(24),
                              child: Text('Take a game to participate'),
                            ),
                    ),
                    Positioned(
                      top: -200,
                      child: CustomPaint(
                        size: Size(650, 600),
                        painter: BgRank(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "Take a game to participate",
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
                                    name: listRank.data != null &&
                                            listRank.data!.length > 1
                                        ? listRank.data![1].user.name!
                                        : "?",
                                    score: listRank.data != null &&
                                            listRank.data!.length > 1
                                        ? listRank.data![1].totalScore
                                        : 0,
                                    category: "Silver",
                                    rank: 2,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ProfileRank(
                                  isMiddle: true,
                                  name: listRank.data != null &&
                                          listRank.data!.isNotEmpty
                                      ? listRank.data![0].user.name!
                                      : "?",
                                  score: listRank.data != null &&
                                          listRank.data!.isNotEmpty
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
                                    name: listRank.data != null &&
                                            listRank.data!.length > 2
                                        ? listRank.data![2].user.name!
                                        : "?",
                                    score: listRank.data != null &&
                                            listRank.data!.length > 2
                                        ? listRank.data![2].totalScore
                                        : 0,
                                    category: "Bronze",
                                    rank: 3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // const SizedBox(height: 170),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}

class BgRank extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = HexColor(mariner100)
      ..strokeWidth = 4
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
