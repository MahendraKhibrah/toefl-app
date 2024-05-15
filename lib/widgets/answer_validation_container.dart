import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';
import '../utils/custom_text_style.dart';
import '../utils/hex_color.dart';

class AnswerValidationContainer extends StatelessWidget {
  const AnswerValidationContainer({
    super.key,
    required this.isCorrect,
    required this.keyAnswer,
    required this.explanation,
  });

  final bool isCorrect;
  final String keyAnswer;
  final String explanation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HexColor(isCorrect ? verySoftGreen : softRed),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 14, right: 12, bottom: 12, top: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
                'assets/icons/${isCorrect ? 'ic_correct' : 'ic_incorrect'}.svg'),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCorrect ? 'Correct' : 'Incorrect',
                  style: CustomTextStyle.extraBold16.copyWith(
                    color: HexColor(isCorrect ? colorSuccess : colorError),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Text(
                    'Key answer : $keyAnswer',
                    style: CustomTextStyle.bold16.copyWith(fontSize: 12),
                  ),
                ),
                SizedBox(
                  height: explanation.isEmpty ? 0 : 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Text(
                    explanation,
                    style: CustomTextStyle.normal12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
