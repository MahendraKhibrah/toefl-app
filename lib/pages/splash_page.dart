import 'package:flutter/material.dart';
import 'package:toefl/widgets/border_button.dart';

import '../utils/colors.dart';
import '../utils/custom_text_style.dart';
import '../utils/hex_color.dart';
import '../widgets/blue_button.dart';
import '../widgets/blue_container.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlueButton(
              title: 'Retake',
              onTap: () {},
            ),
            const SizedBox(
              height: 15,
            ),
            BlueButton(
              title: 'Disable Button',
              onTap: () {},
              isDisabled: true,
              size: 300,
            ),
            const SizedBox(
              height: 15,
            ),
            const BlueContainer(
              child: Text("test test test\ntest test\ntest "
                  "skdmskdm sdkfmsdkfm ksdmfksdmf sdkfmskfm skfmskmf"),
            ),
            const SizedBox(
              height: 15,
            ),
            BorderButton(
              title: 'Cancel',
              onTap: () {},
            ),
            const SizedBox(
              height: 15,
            ),
            AnswerButton(
              onTap: () {},
              title: 'INI BISA DIPENCET',
            ),
            const SizedBox(
              height: 15,
            ),
            AnswerButton(
              isAnswerTrue: true,
              onTap: () {},
              title:
                  '(A) APAKAH SUDAH MAKAN? akdmakdm akdmakdm akdmadkm akdmadkm'
                  'ssd,ls,dl,djnajdna aakdak akdmak',
            ),
          ],
        ),
      ),
    );
  }
}

class AnswerButton extends StatefulWidget {
  const AnswerButton({
    super.key,
    this.isDisabled = false,
    this.isAnswerFalse = false,
    this.isAnswerTrue = false,
    required this.onTap,
    required this.title,
  });

  final bool isDisabled;
  final bool isAnswerFalse;
  final bool isAnswerTrue;
  final Function onTap;
  final String title;

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  bool isAnswer = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!(widget.isDisabled ||
            widget.isAnswerFalse ||
            widget.isAnswerTrue)) {
          setState(() {
            isAnswer = !isAnswer;
          });
          widget.onTap();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.isAnswerTrue
              ? HexColor(colorSuccess)
              : widget.isAnswerFalse
                  ? HexColor(colorError)
                  : isAnswer
                      ? HexColor(mariner100)
                      : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: HexColor(isAnswer ? mariner400 : neutral40),
            width: (widget.isAnswerFalse || widget.isAnswerTrue) ? 0 : 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(
                  widget.title,
                  style: CustomTextStyle.light13.copyWith(
                      color: (widget.isAnswerFalse || widget.isAnswerTrue)
                          ? Colors.white
                          : Colors.black),
                ),
              ),
              const Spacer(),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: HexColor(
                      widget.isAnswerTrue
                          ? softGreen
                          : widget.isAnswerFalse
                              ? softRed
                              : isAnswer
                                  ? mariner400
                                  : neutral40,
                    ),
                    width: (isAnswer ||
                            widget.isAnswerTrue ||
                            widget.isAnswerFalse)
                        ? 6
                        : 2,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
