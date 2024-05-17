import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toefl/models/quiz.dart';
import 'package:toefl/models/user.dart';
import 'package:toefl/remote/api/quiz_api.dart';
import 'package:toefl/remote/api/user_api.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';

class GameButton extends StatelessWidget {
  final Quiz quiz;
  const GameButton({
    super.key,
    required this.quiz,
  });

  @override
  Widget build(BuildContext context) {
    // final quizApi = QuizApi();
    // Quiz? quiz;
    bool isAlready = false;

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
                            text: '480',
                            style: CustomTextStyle.gameCardScoreSubTitle,
                            children: [
                              TextSpan(
                                  text: ' / Good Job',
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
                          'assets/images/vocabulary.svg',
                          color: HexColor(mariner900),
                        ),
                      ),
                      trailing: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              HexColor(mariner700),
                            ),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            maximumSize:
                                MaterialStatePropertyAll(Size(100, 45))),
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          Navigator.of(context).pushNamed(RouteKey.quiz,
                              arguments: {'quizId': quiz.id});
                        },
                        child: Container(
                          height: 45,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Start',
                              style: CustomTextStyle.gameCardStartTitle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Stack(
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
                    // height: 30,
                    width: 66,
                    // decoration: BoxDecoration(
                    //     color: HexColor(mariner500),
                    //     borderRadius: BorderRadius.circular(6)),
                    child: SvgPicture.asset(
                      'assets/images/game_book.svg',
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
                          '80',
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
        ),
      ),
    );
  }
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
