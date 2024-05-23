import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toefl/models/quiz_game_result.dart';
import 'package:toefl/pages/games/quiz/finish_quiz_page.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class SplashPerfect extends StatefulWidget {
  final QuizGameResult result;
  const SplashPerfect({super.key, required this.result});

  @override
  State<SplashPerfect> createState() => _SplashPerfectState();
}

class _SplashPerfectState extends State<SplashPerfect> {
  late double accuracy;
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => FinishQuizPage(
              result: widget.result,
            ),
          ),
        );
      }
    });

    accuracy = (widget.result.total / widget.result.benar) * 100;
    print(accuracy);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.white70.withOpacity(0.4),
            ),
          ),
          Center(
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(horizontal: 29),
              content: Text(
                accuracy > 90
                    ? "PERFECT!"
                    : accuracy > 70
                        ? "GREAT!"
                        : accuracy > 50
                            ? "GOOD"
                            : accuracy >= 40
                                ? "FAIR"
                                : "NEEDS IMPROVEMENT",
              ),
              contentTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 55,
                color: HexColor(mariner900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
