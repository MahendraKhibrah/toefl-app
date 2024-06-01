import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toefl/models/games/user_rank.dart';
import 'package:toefl/models/leader_board.dart';
import 'package:toefl/models/user.dart';
import 'package:toefl/remote/api/leader_board_api.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class UserRankCard extends StatefulWidget {
  const UserRankCard({
    super.key,
  });

  @override
  State<UserRankCard> createState() => _UserRankCardState();
}

class _UserRankCardState extends State<UserRankCard> {
  final leaderBoardApi = LeaderBoardApi();
  UserRank dataRank = UserRank(userId: '');
  bool isLoading = false;

  List<String> medal = [
    'assets/images/emptymedal.svg',
    'assets/images/goldmedal.svg',
    'assets/images/silvermedal.svg',
    'assets/images/bronzemedal.svg',
    'assets/images/belowmedal.svg',
  ];

  int currentRank = 0;

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
      UserRank temp = await leaderBoardApi.getLeaderBoardEntries();

      if (temp.data != null && temp.data!.isNotEmpty) {
        int index = 0;
        for (var e in temp.data!) {
          if (e.userId == temp.userId) {
            if (index >= 10) {
              setState(() {
                currentRank = 0;
              });
            } else {
              setState(() {
                currentRank = index + 1;
              });
            }
          }
          index++;
        }
      }

      setState(() {
        dataRank = temp;
      });
    } catch (e) {
      print("Error in fetchLeaderBoard: $e");
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.aspectRatio * 50),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.aspectRatio * 25),
          color: HexColor(mariner700)),
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/bgrankcard.svg',
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.aspectRatio * 50,
                    left: MediaQuery.of(context).size.aspectRatio * 60),
                child: Skeletonizer(
                  enabled: isLoading,
                  child: Skeleton.leaf(
                    child: SvgPicture.asset(
                      currentRank > 0 && currentRank <= 3
                          ? medal[currentRank]
                          : currentRank == 0
                              ? medal[0]
                              : medal[4],
                      height: MediaQuery.of(context).size.aspectRatio * 240,
                    ),
                  ),
                ),
              )
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.aspectRatio * 330,
                          right: MediaQuery.of(context).size.aspectRatio * 20,
                          top: MediaQuery.of(context).size.aspectRatio * 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Skeletonizer(
                            enabled: isLoading,
                            child: Skeleton.leaf(
                              child: Text(
                                currentRank == 1
                                    ? 'GOLD MEDALIST'
                                    : currentRank == 2
                                        ? "SILVER MEDALIST"
                                        : currentRank == 3
                                            ? 'BRONZE MEDALIST'
                                            : currentRank == 0
                                                ? 'UNRANKED'
                                                : 'RANK $currentRank',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily:
                                      GoogleFonts.passionOne().fontFamily,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            currentRank <= 10 && currentRank > 0
                                ? 'Congratulations to our top achievers! Keep up the great work!'
                                : 'Play Some Games to achive Rank',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              color: Colors.white,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pushNamed(
                                context, RouteKey.rank,
                                arguments: {"dataRank": dataRank}),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              minimumSize: Size(100, 24),
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.aspectRatio *
                                          15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.aspectRatio *
                                        125),
                              ),
                            ),
                            child: Text(
                              'See Ranks',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: GoogleFonts.nunito().fontFamily,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getMedalSvg(String path, BuildContext context) {
    return SvgPicture.asset(
      path,
      height: MediaQuery.of(context).size.aspectRatio * 240,
    );
  }
}
