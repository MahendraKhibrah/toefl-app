import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              // width: MediaQuery.of(context).size.width* 1/8,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ToeflProgressIndicator(
                          value: 0.85,
                          size: MediaQuery.of(context).size.width * 1 / 6),
                      SizedBox(width: 12),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.54,
                            height: MediaQuery.of(context).size.height * 1 / 20,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: SvgPicture.asset(
                                      'assets/icons/ic_time.svg'),
                                  onPressed: () {},
                                ),
                                Text(
                                  "Total time",
                                  style: CustomTextStyle.medium14,
                                ),
                                Text(
                                  "55m 30s",
                                  style: CustomTextStyle.bold16,
                                )
                              ],
                            ), // Atur warna sesuai kebutuhan
                          ),
                          SizedBox(height: 6),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.54,
                            height: MediaQuery.of(context).size.height * 1 / 20,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  icon: SvgPicture.asset(
                                      'assets/icons/ic_time.svg'),
                                  onPressed: () {},
                                ),
                                Text(
                                  "Correct\nQuestion",
                                  style: CustomTextStyle.medium14,
                                ),
                                Text(
                                  "41/70",
                                  style: CustomTextStyle.bold16,
                                )
                              ],
                            ), // Atur warna sesuai kebutuhan
                          ),
                          // Berikan jarak vertikal
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BlueButton(
                        size: MediaQuery.of(context).size.width * 0.38,
                        title: 'Review',
                        onTap: () {
                          // Action when button is pressed
                        },
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
            SizedBox(
              height: 24,
            ),
            BlueContainer(
              showShadow: true,
              child: Stack(
                
              ),
            )
          ],
        ),
      ),
    );
  }
}
