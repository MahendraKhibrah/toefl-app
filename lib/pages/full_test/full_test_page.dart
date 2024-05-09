import 'package:flutter/material.dart';
import 'package:toefl/pages/full_test/submit_dialog.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/answer_button.dart';

import 'bottom_sheet_full_test.dart';

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
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 0, vertical: 0),
                                        content: SubmitDialog(
                                          onNo: () {
                                            Navigator.pop(context);
                                          },
                                          onYes: () {
                                            Navigator.pop(context);
                                          },
                                        ));
                                  });
                            },
                            child: Text(
                              "Submit",
                              style: CustomTextStyle.extraBold16
                                  .copyWith(color: HexColor(mariner700)),
                            ),
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
