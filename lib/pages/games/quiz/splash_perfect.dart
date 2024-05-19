import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toefl/pages/games/quiz/finish_quiz_page.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class SplashPerfect extends StatefulWidget {
  const SplashPerfect({super.key});

  @override
  State<SplashPerfect> createState() => _SplashPerfectState();
}

class _SplashPerfectState extends State<SplashPerfect> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => FinishQuizPage(),
          ),
        );
      }
    });
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
                "PERFECT!",
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


