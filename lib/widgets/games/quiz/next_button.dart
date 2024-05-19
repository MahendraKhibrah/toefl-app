import 'package:flutter/material.dart';
import 'package:toefl/pages/games/quiz/finish_quiz_page.dart';
import 'package:toefl/pages/games/quiz/splash_perfect.dart';
import 'package:toefl/widgets/blue_button.dart';

class NextButton extends StatelessWidget {
  final PageController pageController;
  const NextButton({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return BlueButton(
      title: 'Next',
      onTap: () {
        // Ensure that pageController.page is not null before checking its value
        if (pageController.page != null) {
          // Get the current page index
          int currentPage = pageController.page!.round();
          // Get the last page index
          int lastPage = pageController.positions.length - 1;

          if (currentPage == lastPage) {
            // If on the last page, navigate to FinishQuizPage
            showDialog(
              context: context,
              builder: (context) => SplashPerfect(),
            );
          } else {
            // Otherwise, move to the next page
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
