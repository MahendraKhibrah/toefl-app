import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toefl/models/estimated_score.dart' as model;
import 'package:toefl/remote/api/estimated_score.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/toefl_progress_indicator.dart';

class EstimatedScoreWidget extends StatefulWidget {
  EstimatedScoreWidget({super.key});

  @override
  State<EstimatedScoreWidget> createState() => _EstimatedScoreWidgetState();
}

class _EstimatedScoreWidgetState extends State<EstimatedScoreWidget> {
  final estimatedScoreApi = EstimatedScoreApi();
  model.EstimatedScore? estimatedScore;
  Map<String, dynamic> score = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchEstimatedScore();
  }

  void fetchEstimatedScore() async {
    _setLoadingState(true);

    try {
      model.EstimatedScore temp = await estimatedScoreApi.getEstimatedScore();
      _updateScore(temp);
    } catch (e) {
      print("Error in fetchEstimatedScore: $e");
    } finally {
      _setLoadingState(false);
    }
  }

  void _setLoadingState(bool isLoading) {
    if (mounted) {
      setState(() {
        this.isLoading = isLoading;
      });
    }
  }

  void _updateScore(model.EstimatedScore temp) {
    if (mounted) {
      setState(() {
        estimatedScore = temp;
        score = {
          'Listening Score': temp.scoreListening,
          'Structure Score': temp.scoreStructure,
          'Reading Score': temp.scoreReading,
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4.5,
      child: PageView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Skeletonizer(
            enabled: isLoading,
            child: Skeleton.leaf(
              child: LayoutBuilder(builder: (context, constraint) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: HexColor(mariner800)),
                      margin: EdgeInsets.symmetric(horizontal: 24),
                    ),
                    Positioned(
                        top: (constraint.maxHeight / 20),
                        right: -(constraint.maxHeight / 20),
                        child: SvgPicture.asset(
                          "assets/images/vector_bg_ec.svg",
                          width: constraint.maxHeight / 0.5,
                          // width: 600,
                        )),
                    Positioned(
                        child: Container(
                      width: MediaQuery.of(context).size.height / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${estimatedScore?.userScore}",
                                      style: TextStyle(
                                          fontSize: constraint.maxHeight / 7,
                                          fontWeight: FontWeight.w800,
                                          height: 0.9,
                                          color: HexColor(mariner300)),
                                    ),
                                    Text(
                                      "/${estimatedScore?.targetUser}",
                                      style: TextStyle(
                                          fontSize: constraint.maxHeight / 10,
                                          fontWeight: FontWeight.w800,
                                          color: HexColor(neutral20)),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                child: ToeflProgressIndicator(
                                  value: (estimatedScore?.userScore ?? 0) /
                                      _getTargetScore(),
                                  scale: constraint.maxHeight / 150,
                                  strokeWidth: constraint.maxHeight / 10,
                                  strokeScaler: constraint.maxHeight / 180,
                                  activeHexColor: mariner100,
                                  nonActiveHexColor: mariner300,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // "Estimated score",
                                'estimated_score'.tr(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: HexColor(mariner200),
                                    height: 2),
                              ),
                              ...score.entries.map(
                                (entry) => Text(
                                  '${entry.key}: ${entry.value}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: HexColor(neutral10),
                                  ),
                                ),
                              ),
                              Text('take_full'.tr(),
                                  style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w300,
                                      color: HexColor(neutral10),
                                      height: 2)),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: TextButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                  ),
                                  child: Text(
                                    'set_now'.tr(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: HexColor(mariner900)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
                  ],
                );
              }),
            ),
          ),
          Container(
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
                      child: SvgPicture.asset(
                        'assets/images/goldmedal.svg',
                        height: MediaQuery.of(context).size.aspectRatio * 240,
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
                                left: MediaQuery.of(context).size.aspectRatio *
                                    330,
                                right: MediaQuery.of(context).size.aspectRatio *
                                    20,
                                top: MediaQuery.of(context).size.aspectRatio *
                                    50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'GOLD MEDALIST',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily:
                                        GoogleFonts.passionOne().fontFamily,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Congratulations to our top achievers! Keep up the great work!',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: GoogleFonts.nunito().fontFamily,
                                    color: Colors.white,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    minimumSize: Size(100, 24),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context)
                                                .size
                                                .aspectRatio *
                                            15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context)
                                                  .size
                                                  .aspectRatio *
                                              125),
                                    ),
                                  ),
                                  child: Text(
                                    'See Ranks',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
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
          ),
        ],
      ),
    );
  }

  Widget _getMedalSvg(String medalType, BuildContext context) {
    String assetPath;
    switch (medalType) {
      case 'gold':
        assetPath = 'assets/images/goldmedal.svg';
        break;
      case 'silver':
        assetPath = 'assets/images/silvermedal.svg';
        break;
      case 'bronze':
        assetPath = 'assets/images/bronzemedal.svg';
        break;
      case 'below':
        assetPath = 'assets/images/belowmedal.svg';
        break;
      case 'empty':
      default:
        assetPath = 'assets/images/emptymedal.svg';
        break;
    }
    return SvgPicture.asset(
      assetPath,
      height: MediaQuery.of(context).size.aspectRatio * 240,
    );
  }

  int _getTargetScore() {
    var tmp = estimatedScore?.targetUser ?? 0;
    return tmp <= 0 ? 1 : tmp;
  }
}
