import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/quiz/modal/modal_confirmation.dart';

class StepProgress extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final int currentStep;
  final int steps;
  final String quizType;

  const StepProgress(
      {super.key,
      this.height = 60,
      required this.currentStep,
      required this.steps,
      required this.quizType});

  @override
  State<StepProgress> createState() => _StepProgressState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}

class _StepProgressState extends State<StepProgress> {
  double widthProgress = 0;
  List randomWordsList = [];

  bool loading = false;

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
    return AppBar(
      scrolledUnderElevation: 0,
      titleSpacing: 0,
      leading: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return ModalConfirmation(
                message: "Are you sure want to abort this quiz?",
                leftTitle: "Cancel",
                rightTitle: "Confirm",
                leftFunction: () => Navigator.pop(context),
                rightFunction: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteKey.main,
                  (route) => false,
                ),
              );
            },
          );
        },
        icon: Icon(
          Icons.close,
        ),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.quizType}: Questions ${(widget.currentStep + 1).toInt()} of ${widget.steps.toInt()}',
                style: CustomTextStyle.bold18.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 9,
                  margin: EdgeInsets.only(right: 24),
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
        ],
      ),
    );
  }
}
