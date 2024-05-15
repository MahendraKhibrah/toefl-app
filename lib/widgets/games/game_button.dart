import 'package:flutter/material.dart';
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
          bottom: 10,
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
        Container(
          margin: EdgeInsets.only(bottom: 35),
          child: InkWell(
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
                    child: Column(
                      children: [
                        CustomPaint(
                          painter: SliderPaint(),
                        ),
                        TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();

                              Navigator.of(context).pushNamed(RouteKey.quiz,
                                  arguments: {"quizId": quiz.id});
                            },
                            child: Text('test'))
                      ],
                    )),
              );

              // Find the ScaffoldMessenger in the widget tree
              // and use it to show a SnackBar.
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: Container(
              alignment: Alignment.center,
              height: 80,
              width: 60,
              decoration: BoxDecoration(
                  color: HexColor(mariner500),
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
        )
      ],
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
    paint.color = HexColor(neutral40);

    Path path = Path();

    path.moveTo(-10, 0);
    path.lineTo(10, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
