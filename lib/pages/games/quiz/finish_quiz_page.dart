import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toefl/models/quiz_game_result.dart';
import 'package:toefl/pages/games/quiz/quiz_page.dart';
import 'package:toefl/pages/games/quiz/splash_perfect.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/widgets/blue_button.dart';
import 'package:toefl/widgets/games/quiz/result_quiz.dart';

class FinishQuizPage extends StatefulWidget {
  final QuizGameResult result;
  const FinishQuizPage({super.key, required this.result});

  @override
  State<FinishQuizPage> createState() => _FinishQuizPageState();
}

class _FinishQuizPageState extends State<FinishQuizPage> {
  // void _showDialog()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // diisi maskot
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                child: ResultQuiz(
                  result: widget.result,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              BlueButton(
                title: "Continue",
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteKey.main,
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
