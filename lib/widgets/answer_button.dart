import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/custom_text_style.dart';
import '../utils/hex_color.dart';

class AnswerButton extends StatefulWidget {
  const AnswerButton({
    super.key,
    this.isDisabled = false,
    this.isAnswerFalse = false,
    this.isAnswerTrue = false,
    required this.onTap,
    required this.title,
    required this.isActive,
  });

  final bool isDisabled;
  final bool isAnswerFalse;
  final bool isAnswerTrue;
  final Function onTap;
  final String title;
  final bool isActive;

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  // bool isAnswer = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.isAnswerTrue
              ? HexColor(colorSuccess)
              : widget.isAnswerFalse
                  ? HexColor(colorError)
                  : widget.isActive
                      ? HexColor(mariner100)
                      : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: HexColor(widget.isActive ? mariner400 : neutral40),
            width: (widget.isAnswerFalse || widget.isAnswerTrue) ? 0 : 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
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
                              : widget.isActive
                                  ? mariner400
                                  : neutral40,
                    ),
                    width: (widget.isActive ||
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
