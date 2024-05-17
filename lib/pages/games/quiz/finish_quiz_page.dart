import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toefl/pages/games/quiz/quiz_page.dart';
import 'package:toefl/pages/games/quiz/splash_perfect.dart';
import 'package:toefl/widgets/blue_button.dart';
import 'package:toefl/widgets/games/quiz/result_quiz.dart';

class FinishQuizPage extends StatefulWidget {
  const FinishQuizPage({super.key});

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
              SvgPicture.asset(
                'assets/images/login.svg',
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 60,
              ),
              SizedBox(
                child: ResultQuiz(),
              ),
              SizedBox(
                height: 60,
              ),
              BlueButton(
                title: "Continue",
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => QuizPage(),
                    ),
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
