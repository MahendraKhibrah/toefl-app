import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_button.dart';
import 'package:toefl/widgets/blue_container.dart';
import 'package:toefl/widgets/toefl_progress_indicator.dart';

class TestResultPage extends StatefulWidget {
  const TestResultPage({Key? key}) : super(key: key);

  @override
  State<TestResultPage> createState() => _TestResultPageState();
}

class _TestResultPageState extends State<TestResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "TEST RESULT",
          style: CustomTextStyle.extraBold16,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            BlueContainer(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 90,
                            height: 120,
                            child: ToeflProgressIndicator(
                              value: 0.85,
                              activeHexColor: mariner800,
                              nonActiveHexColor: neutral40,
                              size: MediaQuery.of(context).size.width * 1 / 5,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Text(
                                "85%",
                                textAlign: TextAlign.center,
                                style: CustomTextStyle.extrabold24
                                    .copyWith(color: HexColor(mariner800)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 12),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.54,
                            height: MediaQuery.of(context).size.height * 1 / 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: SvgPicture.asset(
                                      'assets/icons/ic_time.svg'),
                                  onPressed: () {},
                                ),
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    "Total time",
                                    style: CustomTextStyle.medium14,
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    "55m 30s",
                                    style: CustomTextStyle.bold16,
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 6),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.54,
                            height: MediaQuery.of(context).size.height * 1 / 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: SvgPicture.asset(
                                      'assets/icons/ic_checklist.svg'),
                                  onPressed: () {},
                                ),
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    "Correct\nquestion",
                                    style: CustomTextStyle.medium14,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    "41/70",
                                    style: CustomTextStyle.bold16,
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.38,
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: HexColor(mariner700))),
                          child: Text("Review",
                              textAlign: TextAlign.center,
                              style: CustomTextStyle.bold18
                                  .copyWith(color: HexColor(mariner700))),
                        ),
                      ),
                      SizedBox(width: 4),
                      BlueButton(
                        size: MediaQuery.of(context).size.width * 0.38,
                        title: 'Retake',
                        onTap: () {
                          // Action when button is pressed
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Stack(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 12),
                  // margin: EdgeInsets.only(top: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: HexColor(primaryWhite),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(0.5), // Warna bayangan dengan opasitas
                        blurRadius: 1, // Radius blur bayangan
                        offset:
                            Offset(0, 2), // Perpindahan bayangan dari kontainer
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildContainerTest(
                        partText: "Part A",
                        progressValue: 0.8,
                        progressText: "80%",
                        totalQuestions: "12/15",
                        correctness: "Correct",
                        progressColor: Colors.green,
                      ),
                      SizedBox(height: 12),
                      _buildContainerTest(
                        partText: "Part B",
                        progressValue: 0.6,
                        progressText: "60%",
                        totalQuestions: "2/4",
                        correctness: "Correct",
                        progressColor: HexColor(colorWarning),
                      ),
                      SizedBox(height: 12),
                      _buildContainerTest(
                        partText: "Part C",
                        progressValue: 0.17,
                        progressText: "17%",
                        totalQuestions: "1/6",
                        correctness: "Correct",
                        progressColor: HexColor(colorError),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: HexColor(mariner500),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(0.5), // Warna bayangan dengan opasitas
                        blurRadius: 1, // Radius blur bayangan
                        offset:
                            Offset(0, 1), // Perpindahan bayangan dari kontainer
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Listening Comprehension : ",
                          style: CustomTextStyle.bold16
                              .copyWith(color: HexColor(primaryWhite))),
                      Text("15/25",
                          style: CustomTextStyle.extraBold16
                              .copyWith(color: HexColor(mariner950))),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 18),
            Stack(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: 60, left: 20, right: 24, bottom: 12),
                  // margin: EdgeInsets.only(top: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: HexColor(primaryWhite),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(0.5), // Warna bayangan dengan opasitas
                        blurRadius: 1, // Radius blur bayangan
                        offset:
                            Offset(0, 2), // Perpindahan bayangan dari kontainer
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildContainerTest(
                        partText: "Part A",
                        progressValue: 0.13,
                        progressText: "13%",
                        totalQuestions: "1/7",
                        correctness: "Correct",
                        progressColor: HexColor(colorError),
                      ),
                      SizedBox(height: 12),
                      _buildContainerTest(
                        partText: "Part B",
                        progressValue: 0.6,
                        progressText: "40%",
                        totalQuestions: "5/12",
                        correctness: "Correct",
                        progressColor: HexColor(colorWarning),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: HexColor(mariner500),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(0.5), // Warna bayangan dengan opasitas
                        blurRadius: 1, // Radius blur bayangan
                        offset:
                            Offset(0, 1), // Perpindahan bayangan dari kontainer
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Structure : ",
                          style: CustomTextStyle.bold16
                              .copyWith(color: HexColor(primaryWhite))),
                      Text("6/19",
                          style: CustomTextStyle.extraBold16
                              .copyWith(color: HexColor(mariner950))),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 18),
            Stack(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: 60, left: 20, right: 24, bottom: 12),
                  // margin: EdgeInsets.only(top: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: HexColor(primaryWhite),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(0.5), // Warna bayangan dengan opasitas
                        blurRadius: 1, // Radius blur bayangan
                        offset:
                            Offset(0, 2), // Perpindahan bayangan dari kontainer
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildContainerTest(
                        partText: "Part A",
                        progressValue: 0.9,
                        progressText: "90%",
                        totalQuestions: "20/25",
                        correctness: "Correct",
                        progressColor: Colors.green,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: HexColor(mariner500),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(0.5), // Warna bayangan dengan opasitas
                        blurRadius: 1, // Radius blur bayangan
                        offset:
                            Offset(0, 1), // Perpindahan bayangan dari kontainer
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Reading Comprehension : ",
                          style: CustomTextStyle.bold16
                              .copyWith(color: HexColor(primaryWhite))),
                      Text("20/25",
                          style: CustomTextStyle.extraBold16
                              .copyWith(color: HexColor(mariner950))),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 18),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: HexColor(mariner700))),
                child: Text("Back To Course",
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.bold18
                        .copyWith(color: HexColor(mariner700))),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildContainerTest({
  required String partText,
  required double progressValue,
  required String progressText,
  required String totalQuestions,
  required String correctness,
  required Color progressColor,
}) {
  return Row(
    children: [
      Text(
        partText,
        style: CustomTextStyle.semibold12.copyWith(color: HexColor(mariner700)),
      ),
      SizedBox(width: 8),
      SizedBox(
        width: 50,
        child: Text(
          totalQuestions,
          textAlign: TextAlign.center,
          style: CustomTextStyle.bold12.copyWith(color: HexColor(mariner900)),
        ),
      ),
      SvgPicture.asset(
        "assets/icons/ic_pembatas_putih.svg",
      ),
      SizedBox(width: 8),
      Text(
        correctness,
        style: CustomTextStyle.regular10.copyWith(color: HexColor(neutral50)),
      ),
      SizedBox(width: 8),
      Expanded(
        child: LinearProgressIndicator(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          minHeight: 8,
          backgroundColor: HexColor(mariner100),
          value: progressValue,
          valueColor: AlwaysStoppedAnimation<Color>(progressColor),
        ),
      ),
      SizedBox(width: 8),
      Text(
        progressText,
        style: CustomTextStyle.bold12.copyWith(color: HexColor(mariner700)),
      ),
    ],
  );
}
