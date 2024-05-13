import 'package:flutter/material.dart';
import 'package:toefl/widgets/blue_button.dart';

class NextButton extends StatelessWidget {
  final PageController pageController;
  const NextButton({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return BlueButton(
      title: 'Next',
      onTap: () {
        pageController.previousPage(
            duration: Duration(milliseconds: 500), 
            curve: Curves.ease);
      },
    );
  }
}
