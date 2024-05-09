import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toefl/utils/custom_text_style.dart';

import '../../utils/colors.dart';
import '../../utils/hex_color.dart';

class BottomSheetTranscript extends StatelessWidget {
  const BottomSheetTranscript({super.key});

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
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "this is Title",
                      style: CustomTextStyle.bold16.copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Located along the eastern shore of Canawap Bay, the Crescent Moon Bistro is a unique venue for birthday parties, weddings, corporate gatherings, and a host of other social events. \n\nOur chefs work with you to craft a perfect menu, while our coordinators will see to it that your event is superbly organized. Rental pricing is based on the date, type of event, and number of attendees.\n\nYou are welcome to tour our facility on October 10 from 11:00 AM. to 2:00 PM. Meet with our coordinators and culinary staff, and sample items from our creative menu. \n\nAdmission is free, but registration is required. We are offering 25% off on any booking made during this open house on October 10. For more information, please visit our website at www.crescentmoonbistro.com.",
                      style: CustomTextStyle.normal12.copyWith(fontSize: 14),
                    ),
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
