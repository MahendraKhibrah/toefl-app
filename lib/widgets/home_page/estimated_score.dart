import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toefl/models/estimated_score.dart' as model;
import 'package:toefl/pages/rank_page.dart';
import 'package:toefl/remote/api/estimated_score.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/quiz/modal/modal_confirmation.dart';
import 'package:toefl/widgets/toefl_progress_indicator.dart';

import 'user_rank_card.dart';

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
                                  onPressed: () => Navigator.pushNamed(
                                      context, RouteKey.setTargetPage),
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
          UserRankCard(),
        ],
      ),
    );
  }

  int _getTargetScore() {
    var tmp = estimatedScore?.targetUser ?? 0;
    return tmp <= 0 ? 1 : tmp;
  }
}
