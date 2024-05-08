import 'package:flutter/material.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/answer_button.dart';

class FullTestPage extends StatefulWidget {
  const FullTestPage({super.key});

  @override
  State<FullTestPage> createState() => _FullTestPageState();
}

class _FullTestPageState extends State<FullTestPage> {
  var activeIndex = -1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 50,
              child: SizedBox(
                width: screenWidth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Center(
                        child: SizedBox(
                          width: screenWidth,
                          child: Center(
                            child: Text(
                              "TEST 1",
                              style: CustomTextStyle.extraBold16
                                  .copyWith(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          Text(
                            "Submit",
                            style: CustomTextStyle.extraBold16
                                .copyWith(color: HexColor(mariner700)),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "51/140",
                            style: CustomTextStyle.bold16.copyWith(
                              color: HexColor(mariner700),
                              fontSize: 14,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: screenWidth * 0.58,
                            child: LinearProgressIndicator(
                              value: 0.46,
                              backgroundColor: HexColor(neutral40),
                              color: HexColor(mariner700),
                              minHeight: 7,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.timer,
                            color: HexColor(colorSuccess),
                            size: 18,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "0:30:37",
                            style: CustomTextStyle.bold16.copyWith(
                              color: HexColor(colorSuccess),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: screenWidth * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Question 51",
                              style:
                                  CustomTextStyle.bold16.copyWith(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              "What is the ... having trouble doing?",
                              style: CustomTextStyle.medium14,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            ...List.generate(5, (index) {
                              return Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: AnswerButton(
                                    onTap: () {
                                      setState(() {
                                        activeIndex = index;
                                      });
                                    },
                                    title: "index $index",
                                    isActive: activeIndex == index,
                                  ));
                            })
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              width: screenWidth,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.chevron_left,
                          size: 50,
                        )),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.bookmark_border,
                          size: 35,
                        )),
                    const SizedBox(
                      width: 30,
                    ),
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              // enableDrag: false,
                              builder: (context) {
                                return const BottomSheetFullTest();
                              });
                        },
                        icon: const Icon(
                          Icons.list,
                          size: 50,
                        )),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.chevron_right,
                          size: 50,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
        color: HexColor(neutral10),
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
