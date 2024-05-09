import 'package:flutter/material.dart';
import 'package:toefl/pages/full_test/toefl_audio_player.dart';
import 'package:toefl/widgets/answer_button.dart';

import '../../utils/colors.dart';
import '../../utils/custom_text_style.dart';
import '../../utils/hex_color.dart';
import 'bottom_sheet_transcript.dart';

class FormSection extends StatefulWidget {
  const FormSection({super.key});

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  var activeIndex = -1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        SizedBox(
          width: screenWidth * 0.9,
          height: screenHeight * 0.68,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // BlueContainer(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         "Listening",
                //         style: CustomTextStyle.bold16.copyWith(
                //           fontSize: 14,
                //         ),
                //       ),
                //       const SizedBox(
                //         height: 10,
                //       ),
                //       Text(
                //         "Crescent Moon Bistro Located along the eastern shore of Canawap Bay, the Crescent Moon Bistro is a unique venue for birthday parties, weddings, corporate gatherings, and a host of other social events. Our chefs work with you to craft a perfect menu, while our coordinators will see to it that your event is superbly organized. Rental pricing is based on the date, type of event, and number of attendees.You are welcome to tour our facility on October 10 from 11:00 AM. to 2:00 PM. Meet with our coordinators and culinary staff, and sample items from our creative menu. Admission is free, but registration is required. We are offering 25% off on any booking made during this open house on October 10.",
                //         style: CustomTextStyle.normal12.copyWith(fontSize: 14),
                //       ),
                //     ],
                //   ),
                // ),
                const ToeflAudioPlayer(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Question 51",
                  style: CustomTextStyle.bold16.copyWith(fontSize: 14),
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
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
        Positioned(bottom: 0, right: 0, child: _buildFloatingButton(context))
      ],
    );
  }

  Widget _buildFloatingButton(BuildContext context) {
    return GestureDetector(
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
    );
  }
}
