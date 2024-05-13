import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:toefl/utils/custom_text_style.dart';

import '../../utils/colors.dart';
import '../../utils/hex_color.dart';

class BottomSheetTranscript extends StatelessWidget {
  const BottomSheetTranscript({super.key, required this.htmlText});

  final String htmlText;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
            Center(
              child: Text("Transcript",
                  style: CustomTextStyle.bold16
                      .copyWith(color: HexColor(mariner950), fontSize: 20)),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: HexColor(neutral60),
              thickness: 1,
            ),
            SizedBox(
              height: screenHeight * 0.42,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HtmlWidget(
                      htmlText,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
