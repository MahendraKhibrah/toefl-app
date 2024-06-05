import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toefl/models/game_claim.dart';
import 'package:toefl/models/game_data.dart';
import 'package:toefl/models/quiz.dart';
import 'package:toefl/models/user.dart';
import 'package:toefl/remote/api/game_api.dart';
import 'package:toefl/remote/api/quiz_api.dart';
import 'package:toefl/remote/api/user_api.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/quiz/modal/modal_confirmation.dart';

class GameButton extends StatefulWidget {
  final GameList gameList;
  final bool isLocked;
  const GameButton({
    super.key,
    required this.gameList,
    required this.isLocked,
  });

  @override
  State<GameButton> createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> {
  bool isAlready = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isAlready = widget.gameList.gameClaim!.isEmpty;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final quizApi = QuizApi();

    Quiz quiz = widget.gameList.quiz;
    bool isResume = widget.gameList.gameClaim!.isEmpty
        ? false
        : (widget.gameList.gameClaim?.first.isCompleted == false);
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      overlayColor: MaterialStateProperty.all(HexColor(mariner200)),
      highlightColor: Colors.transparent,
      // splashColor: Colors.transparent,
      onTap: () async {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        // quiz = await quizApi.fetchQuiz('6633127d3a99f7fe4cf8a83f');
        final snackBar = SnackBar(
          backgroundColor: Colors.white,
          padding: EdgeInsets.all(0),
          duration: Duration(days: 365),
          content: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0),
                  ),
                  border: Border.all(width: 0.1)),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  CustomPaint(
                    painter: SliderPaint(),
                  ),
                  Center(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity(vertical: 3),
                      minLeadingWidth: 70,
                      title: Text(
                        quiz.type.name,
                        style: CustomTextStyle.gameCardTitle,
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                            text:
                                '${widget.gameList.gameClaim != null && widget.gameList.gameClaim!.isNotEmpty ? generateHalvingSequence(30, iterations: widget.gameList.gameClaim!.length) : '30'} Points',
                            style: CustomTextStyle.gameCardScoreSubTitle,
                            children: [
                              TextSpan(
                                  text: '',
                                  style:
                                      CustomTextStyle.gameCardPredicateSubTitle)
                            ]),
                      ),
                      leading: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            color: HexColor(mariner100),
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(8),
                        child: SvgPicture.asset(
                          'assets/images/${widget.gameList.quiz.type.name.toLowerCase()}.svg',
                          color: HexColor(mariner900),
                        ),
                      ),
                      trailing: GameButtonSheetButton(
                          isResume: isResume,
                          isLocked: widget.isLocked,
                          isAlready: isAlready,
                          id: widget.gameList.id),
                    ),
                  ),
                ],
              )),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: GameButtonContent(
        quiz: quiz,
        isAlready: isAlready,
        isLocked: widget.isLocked,
      ),
    );
  }
}

class GameButtonSheetButton extends StatelessWidget {
  const GameButtonSheetButton({
    super.key,
    required this.isAlready,
    required this.isResume,
    required this.id,
    required this.isLocked,
  });

  final bool isLocked;
  final bool isAlready;
  final bool isResume;
  final String id;

  @override
  Widget build(BuildContext context) {
    print('adada ' + isResume.toString());
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            HexColor(isAlready && !isResume
                ? isLocked
                    ? neutral20
                    : mariner700
                : '#ffffff'),
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: HexColor(isLocked ? neutral20 : mariner700),
                width: 1.0,
              ),
            ),
          ),
          maximumSize: MaterialStatePropertyAll(Size(100, 45))),
      onPressed: () {
        if (!isLocked) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          if (!isAlready && !isResume) {
            showDialog(
              context: context,
              builder: (context) {
                return ModalConfirmation(
                  message: "Wanna Retake this Quiz?",
                  leftTitle: "Review",
                  rightTitle: "Retake",
                  leftFunction: () => Navigator.of(context).pushNamed(
                    RouteKey.initQuiz,
                    arguments: {'id': id, 'isGame': true, 'isReview': true},
                  ),
                  rightFunction: () => Navigator.of(context).pushNamed(
                    RouteKey.initQuiz,
                    arguments: {'id': id, 'isGame': true},
                  ),
                );
              },
            );
          } else {
            Navigator.of(context).pushNamed(
              RouteKey.initQuiz,
              arguments: {'id': id, 'isGame': true},
            );
          }
        }
      },
      child: Container(
        height: 45,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isLocked)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(Icons.lock, size: 18),
              ),
            Text(
              isResume
                  ? 'Resume'
                  : isAlready
                      ? 'Start'
                      : 'Review',
              style: GoogleFonts.nunito(
                fontSize: 16,
                color: HexColor(isAlready && !isResume
                    ? isLocked
                        ? mariner700
                        : neutral10
                    : mariner700),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameButtonContent extends StatelessWidget {
  const GameButtonContent(
      {super.key,
      required this.quiz,
      required this.isAlready,
      required this.isLocked});

  final Quiz quiz;
  final bool isAlready;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        ClipOval(
          child: Container(
            height: 25,
            width: 120,
            decoration: BoxDecoration(
              color: HexColor(mariner700),
            ),
          ),
        ),
        Positioned(
          bottom: 14,
          child: Container(
            alignment: Alignment.center,
            height: 20,
            width: 80,
            decoration: BoxDecoration(
                color: HexColor(mariner500),
                borderRadius: BorderRadius.circular(100)),
            child: Text(
              quiz.type.name,
              style: CustomTextStyle.gamePartTitle,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
        isAlready
            ? Container(
                margin: EdgeInsets.only(bottom: 35),
                alignment: Alignment.center,
                width: 120,
                child: SvgPicture.asset(
                  'assets/images/game_book${isLocked ? '_locked' : ''}.svg',
                  height: 80,
                  colorFilter: ColorFilter.mode(
                      Color.fromARGB(0, 0, 0, 0), BlendMode.dstOut),
                ),
              )
            : Container(
                margin: EdgeInsets.only(bottom: 35),
                alignment: Alignment.center,
                // height: 30,
                width: 120,
                // decoration: BoxDecoration(
                //     color: HexColor(mariner500),
                //     borderRadius: BorderRadius.circular(6)),
                child: Column(
                  children: [
                    Text(
                      '',
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.gameScoreResult,
                    ),
                    SvgPicture.asset(
                      'assets/images/game_book_opened.svg',
                      height: 30,
                      colorFilter: ColorFilter.mode(
                          Color.fromARGB(0, 0, 0, 0), BlendMode.dstOut),
                    ),
                  ],
                ),
              )
      ],
    );
  }
}

int generateHalvingSequence(double initialValue, {int iterations = 10}) {
  List<double> sequence = [];
  double currentValue = initialValue;

  for (int i = 0; i < iterations; i++) {
    sequence.add(currentValue);
    currentValue /= 2;
  }

  return sequence.last.toInt();
}

class SliderPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    paint.strokeCap = StrokeCap.round;
    paint.color = HexColor(mariner700);

    Path path = Path();

    path.moveTo(-30, 0);
    path.lineTo(30, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
