import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toefl/models/quiz.dart';
import 'package:toefl/remote/api/learning_path_api.dart';
import 'package:toefl/remote/api/quiz_api.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_container.dart';
import 'package:flutter/widgets.dart';

class LearningPathPage extends StatefulWidget {
  final String appBar;
  final String typeId;
  LearningPathPage({super.key, required this.appBar, required this.typeId});

  @override
  State<LearningPathPage> createState() => _LearningPathPageState();
}

class _LearningPathPageState extends State<LearningPathPage> {
  late List<Quiz> quizs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<Quiz>> getQuizByCategory(String typeId) async {
    return await LearningPathApi().getQuizByCategory(typeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          centerTitle: true,
          leading: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(
              Icons.chevron_left_rounded,
              size: 30,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            widget.appBar,
            style: GoogleFonts.nunito(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: HexColor(neutral90)),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Text(
                "Select Lesson to Practice",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: HexColor(neutral60)),
              ),
            ),
            FutureBuilder<List<Quiz>>(
                future: getQuizByCategory(widget.typeId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.isNotEmpty) {
                    List<Quiz>? data = snapshot.data;
                    print(data);
                    return ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                            height: MediaQuery.of(context).size.height / 8,
                            margin: EdgeInsets.only(left: 24, bottom: 20.0),
                            child: Row(
                              children: [
                                MySeparator(
                                    width: 3, color: HexColor(mariner800)),
                                Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 24),
                                        child: LayoutBuilder(
                                          builder: (context, constraint) {
                                            return BlueContainer(
                                                child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    RouteKey.initQuiz,
                                                    arguments: {
                                                      'id': data[index].id,
                                                      'isGame': false,
                                                      'isReview': data[index]
                                                              .quizClaim!
                                                              .isNotEmpty
                                                          ? data[index]
                                                              .quizClaim!
                                                              .first
                                                              .isCompleted
                                                          : false,
                                                    });
                                              },
                                              child: Container(
                                                height:
                                                    constraint.maxHeight / 1,
                                                child: Flex(
                                                  direction: Axis.horizontal,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          data[index].quizName,
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: HexColor(
                                                                  "#2F2F2F")),
                                                        ),
                                                        Text(
                                                            '${data[index].quizClaim!.isNotEmpty ? data[index].quizClaim!.length.toString() : '0'} attempt',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: HexColor(
                                                                    neutral60)))
                                                      ],
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                              vertical: 2),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: HexColor(
                                                                mariner600)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: data[index]
                                                                .quizClaim!
                                                                .isNotEmpty
                                                            ? HexColor(
                                                                neutral10)
                                                            : HexColor(
                                                                mariner600),
                                                      ),
                                                      child: Text(
                                                        data[index]
                                                                .quizClaim!
                                                                .isNotEmpty
                                                            ? data[index]
                                                                    .quizClaim!
                                                                    .first
                                                                    .isCompleted
                                                                ? 'Review'
                                                                : 'Resume'
                                                            : 'Take',
                                                        style: GoogleFonts.nunito(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: data[index]
                                                                    .quizClaim!
                                                                    .isNotEmpty
                                                                ? HexColor(
                                                                    mariner600)
                                                                : HexColor(
                                                                    neutral10)),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ));
                                          },
                                        )))
                              ],
                            ));
                      },
                    );
                  } else {
                    return Text('');
                  }
                }),
          ],
        ));
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.width = 1, this.color = Colors.black})
      : super(key: key);
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxHeight = constraints.constrainHeight();
        const dashHeight = 15.0;
        final dashWidth = width;
        final dashCount = (boxHeight / (2 * dashHeight)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(100)),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.vertical,
        );
      },
    );
  }
}
