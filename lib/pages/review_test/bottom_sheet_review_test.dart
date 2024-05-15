import 'package:flutter/material.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

import '../../models/test/answer.dart';
import '../../utils/custom_text_style.dart';

class BottomSheetReviewTest extends StatelessWidget {
  const BottomSheetReviewTest(
      {super.key, required this.answers, required this.onTap});

  final List<Answer> answers;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * 0.6,
      decoration: BoxDecoration(
        color: HexColor(neutral20),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                width: 65,
                height: 4,
                color: HexColor(neutral60),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: screenWidth,
              child: Center(
                child: Text(
                  "Review Test",
                  style: CustomTextStyle.bold16.copyWith(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              height: 2,
              color: HexColor(neutral40),
            ),
            SizedBox(
                height: screenHeight * 0.45,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 2),
                        child: Text(
                          "Listening",
                          style: CustomTextStyle.bold16.copyWith(fontSize: 15),
                        ),
                      ),
                      ...buildSection(
                          "Part A : Short Talks", onTap, 30, 1, context),
                      ...buildSection(
                          "Part B : Long Conversations", onTap, 8, 31, context),
                      ...buildSection(
                          "Part C : Mini-Lectures", onTap, 12, 39, context),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 2),
                        child: Text(
                          "Structure and Written Expression",
                          style: CustomTextStyle.bold16.copyWith(fontSize: 15),
                        ),
                      ),
                      ...buildSection("Part A: Sentence Completitions", onTap,
                          15, 51, context),
                      ...buildSection(
                          "Part B: Error Recognition", onTap, 25, 66, context),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 2),
                        child: Text(
                          "Reading",
                          style: CustomTextStyle.bold16.copyWith(fontSize: 15),
                        ),
                      ),
                      ...buildSection("", onTap, 50, 91, context),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget buildNumOption(int number, Function onTap, bool isActive) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isActive ? HexColor(colorSuccess) : HexColor(colorError),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            "$number",
            style: CustomTextStyle.bold16.copyWith(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  List buildSection(
    String title,
    Function(int) onTap,
    int total,
    int start,
    BuildContext context,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;

    return [
      title != ""
          ? Text(
              title,
              style: CustomTextStyle.normal12,
            )
          : const SizedBox(),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Center(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: screenWidth * 0.03,
            runSpacing: screenWidth * 0.03,
            children: List.generate(total, (index) {
              return buildNumOption(
                index + start,
                () {
                  Navigator.of(context).pop(index + start);
                },
                answers[index + start - 1].isCorrect,
              );
            }),
          ),
        ),
      ),
    ];
  }
}
