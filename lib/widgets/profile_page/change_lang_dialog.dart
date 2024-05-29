import 'package:flutter/material.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_button.dart';
import 'package:toefl/widgets/border_button.dart';

import '../../utils/colors.dart';
import '../../utils/custom_text_style.dart';

class ChangeLangDialog extends StatelessWidget {
  const ChangeLangDialog({
    super.key,
    required this.onNo,
    required this.onYes,
  });

  final Function onNo;
  final Function onYes;

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Do you want to change the language?",
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
