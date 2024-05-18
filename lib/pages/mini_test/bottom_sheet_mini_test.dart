import 'package:flutter/material.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';

class BottomSheetMiniTest extends StatefulWidget {
  const BottomSheetMiniTest(
      {super.key, required this.filledStatus, required this.onTap});

  final List<bool> filledStatus;
  final Function(int) onTap;

  @override
  State<BottomSheetMiniTest> createState() => _BottomSheetMiniTestState();
}

class _BottomSheetMiniTestState extends State<BottomSheetMiniTest> {
  var selectedPage = 0;
  var pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

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
                buildMenu(
                    "All(${widget.filledStatus.length})", selectedPage == 0,
                    () {
                  setState(() {
                    selectedPage = 0;
                    pageController.animateToPage(0,
                        duration: const Duration(milliseconds: 10),
                        curve: Curves.easeIn);
                  });
                }),
                const Spacer(),
                buildMenu(
                    "Answered(${widget.filledStatus.where((element) => element == true).length})",
                    selectedPage == 1, () {
                  setState(() {
                    selectedPage = 1;
                    pageController.animateToPage(1,
                        duration: const Duration(milliseconds: 10),
                        curve: Curves.easeIn);
                  });
                }),
                const Spacer(),
                buildMenu(
                    "Unanswered(${widget.filledStatus.where((element) => element == false).length})",
                    selectedPage == 2, () {
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
                            "Part A : Short Talks", widget.onTap, 15, 1),
                        ...buildSection(
                            "Part B : Long Conversations", widget.onTap, 5, 16),
                        ...buildSection(
                            "Part C : Mini-Lectures", widget.onTap, 6, 20),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 2),
                          child: Text(
                            "Structure and Written Expression",
                            style:
                                CustomTextStyle.bold16.copyWith(fontSize: 15),
                          ),
                        ),
                        ...buildSection("Part A: Sentence Completitions",
                            widget.onTap, 7, 26),
                        ...buildSection(
                            "Part B: Error Recognition", widget.onTap, 12, 33),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 2),
                          child: Text(
                            "Reading",
                            style:
                                CustomTextStyle.bold16.copyWith(fontSize: 15),
                          ),
                        ),
                        ...buildSection("", widget.onTap, 26, 45),
                      ],
                    ),
                  ),
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
                        ...buildSectionAnswered(
                            "Part A : Short Talks", widget.onTap, 15, 1),
                        ...buildSectionAnswered(
                            "Part B : Long Conversations", widget.onTap, 4, 16),
                        ...buildSectionAnswered(
                            "Part C : Mini-Lectures", widget.onTap, 6, 20),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 2),
                          child: Text(
                            "Structure and Written Expression",
                            style:
                                CustomTextStyle.bold16.copyWith(fontSize: 15),
                          ),
                        ),
                        ...buildSectionAnswered(
                            "Part A: Sentence Completitions",
                            widget.onTap,
                            7,
                            26),
                        ...buildSectionAnswered(
                            "Part B: Error Recognition", widget.onTap, 12, 33),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 2),
                          child: Text(
                            "Reading",
                            style:
                                CustomTextStyle.bold16.copyWith(fontSize: 15),
                          ),
                        ),
                        ...buildSectionAnswered("", widget.onTap, 26, 45),
                      ],
                    ),
                  ),
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
                        ...buildSectionUnanswered(
                            "Part A : Short Talks", widget.onTap, 15, 1),
                        ...buildSectionUnanswered(
                            "Part B : Long Conversations", widget.onTap, 4, 16),
                        ...buildSectionUnanswered(
                            "Part C : Mini-Lectures", widget.onTap, 6, 20),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 2),
                          child: Text(
                            "Structure and Written Expression",
                            style:
                                CustomTextStyle.bold16.copyWith(fontSize: 15),
                          ),
                        ),
                        ...buildSectionUnanswered(
                            "Part A: Sentence Completitions",
                            widget.onTap,
                            7,
                            26),
                        ...buildSectionUnanswered(
                            "Part B: Error Recognition", widget.onTap, 12, 33),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 2),
                          child: Text(
                            "Reading",
                            style:
                                CustomTextStyle.bold16.copyWith(fontSize: 15),
                          ),
                        ),
                        ...buildSectionUnanswered("", widget.onTap, 26, 45),
                      ],
                    ),
                  ),
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
        child: Wrap(
          runAlignment: WrapAlignment.center,
          spacing: screenWidth * 0.03,
          runSpacing: screenWidth * 0.03,
          children: List.generate(total, (index) {
            return buildNumOption(
              index + start,
              () {
                Navigator.of(context).pop(index + start);
              },
              isActive: widget.filledStatus[index + start - 1],
            );
          }),
        ),
      ),
    ];
  }

  List buildSectionAnswered(
    String title,
    Function(int) onTap,
    int total,
    int start,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    var answeredNumberList = <int>[];

    for (var i = start; i < start + total; i++) {
      if (widget.filledStatus[i - 1]) {
        answeredNumberList.add(i);
      }
    }

    return [
      title != "" && answeredNumberList.isNotEmpty
          ? Text(
              title,
              style: CustomTextStyle.normal12,
            )
          : const SizedBox(),
      answeredNumberList.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: screenWidth * 0.03,
                runSpacing: screenWidth * 0.03,
                children: List.generate(answeredNumberList.length, (index) {
                  return buildNumOption(
                    answeredNumberList[index],
                    () {
                      Navigator.of(context).pop(index + start);
                    },
                    isActive: true,
                  );
                }),
              ),
            )
          : const SizedBox(),
    ];
  }

  List buildSectionUnanswered(
    String title,
    Function(int) onTap,
    int total,
    int start,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    var answeredNumberList = <int>[];

    for (var i = start; i < start + total; i++) {
      if (!widget.filledStatus[i - 1]) {
        answeredNumberList.add(i);
      }
    }

    return [
      title != "" && answeredNumberList.isNotEmpty
          ? Text(
              title,
              style: CustomTextStyle.normal12,
            )
          : const SizedBox(),
      answeredNumberList.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: screenWidth * 0.03,
                runSpacing: screenWidth * 0.03,
                children: List.generate(answeredNumberList.length, (index) {
                  return buildNumOption(
                    answeredNumberList[index],
                    () {
                      Navigator.of(context).pop(index + start);
                    },
                    isActive: false,
                  );
                }),
              ),
            )
          : const SizedBox(),
    ];
  }
}
