import 'package:flutter/material.dart';
import 'package:toefl/widgets/blue_button.dart';

class NextButton extends StatelessWidget {
  final PageController pageController;
  final bool isDisabled;
  const NextButton(
      {super.key, required this.pageController, required this.isDisabled});

  @override
  Widget build(BuildContext context) {
    return BlueButton(
      title: 'Next',
      isDisabled: isDisabled,
      onTap: () {
        pageController.nextPage(
            duration: Duration(milliseconds: 200), curve: Curves.ease);
      },
    );
  }
}
