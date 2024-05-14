import 'package:flutter/material.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_button.dart';
import 'package:toefl/widgets/border_button.dart';

import '../../utils/colors.dart';
import '../../utils/custom_text_style.dart';

class FinishedPacketDialog extends StatelessWidget {
  const FinishedPacketDialog({
    super.key,
    required this.onRetake,
    required this.onReview,
  });

  final Function onRetake;
  final Function onReview;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight * 0.2,
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
              "You've finished your test.",
              textAlign: TextAlign.center,
              style: CustomTextStyle.medium14.copyWith(fontSize: 15),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                BorderButton(
                    title: "Review",
                    onTap: () {
                      onRetake();
                    },
                    size: screenWidth * 0.34),
                const Spacer(),
                BlueButton(
                    title: "Retake",
                    onTap: () {
                      onReview();
                    },
                    size: screenWidth * 0.34)
              ],
            )
          ],
        ),
      ),
    );
  }
}
