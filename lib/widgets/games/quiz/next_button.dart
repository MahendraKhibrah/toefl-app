import 'package:flutter/material.dart';
import 'package:toefl/models/quiz_game_result.dart';
import 'package:toefl/pages/games/quiz/finish_quiz_page.dart';
import 'package:toefl/pages/games/quiz/splash_perfect.dart';
import 'package:toefl/remote/api/quiz_api.dart';
import 'package:toefl/widgets/blue_button.dart';

class NextButton extends StatelessWidget {
  final bool? isReview;
  final PageController pageController;
  final String claimId;
  final bool isGame;
  final bool isDisabled;
  const NextButton(
      {super.key,
      required this.pageController,
      required this.isDisabled,
      required this.claimId,
      required this.isGame,
      this.isReview = false});

  @override
  Widget build(BuildContext context) {
    print(pageController.page);
    return Row(
      children: [
        if (isReview! &&
            pageController.page != null &&
            pageController.page!.roundToDouble() >= 1)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 12),
              child: BlueButton(
                title: 'Prev',
                isDisabled: pageController.page != null &&
                    !(pageController.page!.roundToDouble() >= 0),
                onTap: () async {
                  if (pageController.page != null) {
                    int currentPage = pageController.page!.round();
                    int lastPage = pageController.positions.length;
                    if (currentPage != 0) {
                      pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  }
                },
              ),
            ),
          ),
        Expanded(
          child: Padding(
            padding: isReview! &&
                    pageController.page != null &&
                    pageController.page!.roundToDouble() >= 1
                ? EdgeInsets.only(right: 24, left: 12)
                : EdgeInsets.symmetric(horizontal: 24),
            child: BlueButton(
              title: 'Next',
              isDisabled: isDisabled,
              onTap: () async {
                if (pageController.page != null) {
                  int currentPage = pageController.page!.round();
                  int lastPage = pageController.positions.length;
                  print(currentPage);
                  print(lastPage);
                  if (currentPage == lastPage) {
                    QuizGameResult res =
                        await QuizApi().getResult(claimId, isGame);
                    if (!isReview!) {
                      showDialog(
                        context: context,
                        builder: (context) => SplashPerfect(
                          result: res,
                        ),
                      );
                    } else {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => FinishQuizPage(
                            result: res,
                          ),
                        ),
                      );
                    }
                  } else {
                    pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  }
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
