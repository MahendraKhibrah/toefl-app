import 'package:flutter/material.dart';
import 'package:toefl/models/quiz_game_result.dart';
import 'package:toefl/pages/games/quiz/splash_perfect.dart';
import 'package:toefl/remote/api/quiz_api.dart';
import 'package:toefl/widgets/blue_button.dart';

class NextButton extends StatelessWidget {
  final PageController pageController;
  final String claimId;
  final bool isGame;
  final bool isDisabled;
  const NextButton(
      {super.key,
      required this.pageController,
      required this.isDisabled,
      required this.claimId,
      required this.isGame});

  @override
  Widget build(BuildContext context) {
    return BlueButton(
      title: 'Next',
      isDisabled: isDisabled,
      onTap: () async {
        if (pageController.page != null) {
          int currentPage = pageController.page!.round();
          int lastPage = pageController.positions.length;

          if (currentPage == lastPage) {
            QuizGameResult res = await QuizApi().getResult(claimId, isGame);
            showDialog(
              context: context,
              builder: (context) => SplashPerfect(
                result: res,
              ),
            );
          } else {
            pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          }
        }
      },
    );
  }
}
