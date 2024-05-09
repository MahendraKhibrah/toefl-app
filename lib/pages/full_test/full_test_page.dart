import 'package:flutter/material.dart';
import 'package:toefl/pages/full_test/bottom_sheet_transcript.dart';
import 'package:toefl/pages/full_test/submit_dialog.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/answer_button.dart';
import 'package:toefl/widgets/blue_container.dart';

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
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: buildFloatingButton(context),
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
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.68,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BlueContainer(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Listening",
                                      style: CustomTextStyle.bold16.copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Crescent Moon Bistro Located along the eastern shore of Canawap Bay, the Crescent Moon Bistro is a unique venue for birthday parties, weddings, corporate gatherings, and a host of other social events. Our chefs work with you to craft a perfect menu, while our coordinators will see to it that your event is superbly organized. Rental pricing is based on the date, type of event, and number of attendees.You are welcome to tour our facility on October 10 from 11:00 AM. to 2:00 PM. Meet with our coordinators and culinary staff, and sample items from our creative menu. Admission is free, but registration is required. We are offering 25% off on any booking made during this open house on October 10.",
                                      style: CustomTextStyle.normal12
                                          .copyWith(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Question 51",
                                style: CustomTextStyle.bold16
                                    .copyWith(fontSize: 14),
                              ),
                              const SizedBox(
                                height: 2,
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
                              }),
                              // const SizedBox(
                              //   height: 100,
                              // )
                            ],
                          ),
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

  Padding buildFloatingButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 90),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return const BottomSheetTranscript();
              });
        },
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              color: HexColor(mariner500),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(1, 3),
                ),
              ]),
          child: Column(
            children: [
              const SizedBox(
                height: 6,
              ),
              Text(
                "See\nTranscript",
                textAlign: TextAlign.center,
                style: CustomTextStyle.bold16.copyWith(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              const Icon(
                Icons.menu_book_outlined,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
