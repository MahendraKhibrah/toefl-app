import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/custom_text_style.dart';
import '../../utils/hex_color.dart';

class BottomSheetFullTest extends StatefulWidget {
  const BottomSheetFullTest({super.key});

  @override
  State<BottomSheetFullTest> createState() => _BottomSheetFullTestState();
}

class _BottomSheetFullTestState extends State<BottomSheetFullTest> {
  var selectedPage = 0;
  var pageController = PageController();

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
              height: 30,
            ),
            Row(
              children: [
                buildMenu("All(40)", selectedPage == 0, () {
                  setState(() {
                    selectedPage = 0;
                    pageController.animateToPage(0,
                        duration: const Duration(milliseconds: 10),
                        curve: Curves.easeIn);
                  });
                }),
                const Spacer(),
                buildMenu("Answered(4)", selectedPage == 1, () {
                  setState(() {
                    selectedPage = 1;
                    pageController.animateToPage(1,
                        duration: const Duration(milliseconds: 10),
                        curve: Curves.easeIn);
                  });
                }),
                const Spacer(),
                buildMenu("Unanswered(16)", selectedPage == 2, () {
                  setState(() {
                    selectedPage = 2;
                    pageController.animateToPage(2,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  });
                }),
              ],
            ),
            Divider(
              height: 2,
              color: HexColor(neutral40),
            ),
            SizedBox(
              height: screenHeight * 0.45,
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    selectedPage = index;
                  });
                },
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 2),
                          child: Text(
                            "Listening",
                            style:
                                CustomTextStyle.bold16.copyWith(fontSize: 15),
                          ),
                        ),
                        ...buildSection(
                            "Part A : Short Talks", (p0) => null, 30, 1),
                        ...buildSection(
                            "Part B : Long Conversations", (p0) => null, 8, 31),
                        ...buildSection(
                            "Part C : Mini-Lectures", (p0) => null, 12, 39),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 2),
                          child: Text(
                            "Structure and Written Expression",
                            style:
                                CustomTextStyle.bold16.copyWith(fontSize: 15),
                          ),
                        ),
                        ...buildSection("Part A: Sentence Completitions",
                            (p0) => null, 15, 51),
                        ...buildSection(
                            "Part B: Error Recognition", (p0) => null, 25, 66),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 2),
                          child: Text(
                            "Reading",
                            style:
                                CustomTextStyle.bold16.copyWith(fontSize: 15),
                          ),
                        ),
                        ...buildSection("", (p0) => null, 50, 91),
                      ],
                    ),
                  ),
                  const Text("Answered"),
                  const Text("Unanswered")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNumOption(
    int number,
    Function onTap, {
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isActive ? HexColor(mariner700) : Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            "$number",
            style: CustomTextStyle.bold16.copyWith(
              color: isActive ? Colors.white : HexColor(neutral50),
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenu(
    String title,
    bool isActive,
    Function onTap,
  ) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Text(
            title,
            style: CustomTextStyle.medium14.copyWith(
              color: isActive ? Colors.black : HexColor(neutral60),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            width: 80,
            height: 3,
            color: isActive ? HexColor(mariner700) : Colors.transparent,
          ),
        ],
      ),
    );
  }

  List buildSection(
    String title,
    Function(int) onTap,
    int total,
    int start,
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
                () {},
                isActive: false,
              );
            }),
          ),
        ),
      ),
    ];
  }
}
