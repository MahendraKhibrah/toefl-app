import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/custom_text_style.dart';
import '../utils/hex_color.dart';

class BorderButton extends StatelessWidget {
  const BorderButton({
    super.key,
    this.size = -1,
    required this.title,
    required this.onTap,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
  });

  final double size;
  final String title;
  final void Function() onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    double buttonSize =
        size >= 0 ? size : MediaQuery.of(context).size.width * 0.9;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: HexColor(mariner700),
            width: 2,
          ),
        ),
        width: buttonSize,
        child: Padding(
          padding: padding!,
          child: Center(
            child: Text(
              title,
              style: CustomTextStyle.bold16.copyWith(
                color: HexColor(mariner700),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
