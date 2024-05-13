import 'package:flutter/material.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';

class StepProgress extends StatefulWidget {
  final double currentStep;
  final double steps;

  const StepProgress({Key? key, required this.currentStep, required this.steps})
      : super(key: key);

  @override
  State<StepProgress> createState() => _StepProgressState();
}

class _StepProgressState extends State<StepProgress> {
  double widthProgress = 0;

  @override
  void initState() {
    super.initState();
    _onSizeWidget();
  }

  @override
  void didUpdateWidget(covariant StepProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    _onSizeWidget();
  }

  void _onSizeWidget() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (context.size != null && widget.steps > 1) {
        setState(() {
          Size size = context.size!;
          widthProgress = size.width / (widget.steps - 1);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
            Expanded(
              child: Container(
                height: 9,
                margin: EdgeInsets.symmetric(vertical: 16),
                child: Stack(
                  children: [
                    AnimatedContainer(
                      width: widthProgress * widget.currentStep,
                      duration: Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: HexColor(mariner800),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: HexColor(neutral40),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Vocab: Questions ${(widget.currentStep + 1).toInt()} of ${widget.steps.toInt()}',
                style: CustomTextStyle.bold18.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
