import 'package:flutter/material.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_button.dart';
import 'package:toefl/widgets/border_button.dart';

import '../../utils/colors.dart';
import '../../utils/custom_text_style.dart';

class SubmitDialog extends StatelessWidget {
  const SubmitDialog(
      {super.key,
      required this.onNo,
      required this.onYes,
      required this.unAnsweredQuestion});

  final Function onNo;
  final Function onYes;
  final int unAnsweredQuestion;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight * 0.24,
      decoration: BoxDecoration(
        color: HexColor(neutral20),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          children: [
            Text(
              unAnsweredQuestion > 0
                  ? "The are still $unAnsweredQuestion unanswered questions. Do you want to submit your test now?"
                  : "you still have remaining time, are you sure want to finish the test?",
              textAlign: TextAlign.center,
              style: CustomTextStyle.medium14.copyWith(fontSize: 15),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Spacer(),
                BorderButton(
                    title: "No",
                    onTap: () {
                      onNo();
                    },
                    size: screenWidth * 0.3),
                const Spacer(),
                BlueButton(
                    title: "Yes",
                    onTap: () {
                      onYes();
                    },
                    size: screenWidth * 0.3),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
