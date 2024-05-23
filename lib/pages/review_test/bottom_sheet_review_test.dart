import 'package:flutter/material.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

import '../../models/test/answer.dart';
import '../../utils/custom_text_style.dart';

class BottomSheetReviewTest extends StatelessWidget {
  BottomSheetReviewTest(
      {super.key,
      required this.answers,
      required this.onTap,
      this.isFullTest = true});

  final List<Answer> answers;
  final Function(int) onTap;
  final bool isFullTest;

  final startNumberFull = [1, 31, 39, 51, 66, 91];
  final startNumberMini = [1, 16, 20, 26, 33, 45];
  final totalNumberFull = [30, 8, 12, 15, 25, 50];
  final totalNumberMini = [15, 4, 6, 7, 12, 26];

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
                          "Part A : Short Talks",
                          onTap,
                          isFullTest ? totalNumberFull[0] : totalNumberMini[0],
                          isFullTest ? startNumberFull[0] : startNumberMini[0],
                          context),
                      ...buildSection(
                          "Part B : Long Conversations",
                          onTap,
                          isFullTest ? totalNumberFull[1] : totalNumberMini[1],
                          isFullTest ? startNumberFull[1] : startNumberMini[1],
                          context),
                      ...buildSection(
                          "Part C : Mini-Lectures",
                          onTap,
                          isFullTest ? totalNumberFull[2] : totalNumberMini[2],
                          isFullTest ? startNumberFull[2] : startNumberMini[2],
                          context),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 2),
                        child: Text(
                          "Structure and Written Expression",
                          style: CustomTextStyle.bold16.copyWith(fontSize: 15),
                        ),
                      ),
                      ...buildSection(
                          "Part A: Sentence Completitions",
                          onTap,
                          isFullTest ? totalNumberFull[3] : totalNumberMini[3],
                          isFullTest ? startNumberFull[3] : startNumberMini[3],
                          context),
                      ...buildSection(
                          "Part B: Error Recognition",
                          onTap,
                          isFullTest ? totalNumberFull[4] : totalNumberMini[4],
                          isFullTest ? startNumberFull[4] : startNumberMini[4],
                          context),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 2),
                        child: Text(
                          "Reading",
                          style: CustomTextStyle.bold16.copyWith(fontSize: 15),
                        ),
                      ),
                      ...buildSection(
                          "",
                          onTap,
                          isFullTest ? totalNumberFull[5] : totalNumberMini[5],
                          isFullTest ? startNumberFull[5] : startNumberMini[5],
                          context),
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
    ];
  }
}
