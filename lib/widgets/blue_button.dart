import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';
import '../utils/custom_text_style.dart';
import '../utils/hex_color.dart';

class BlueButton extends StatelessWidget {
  const BlueButton({
    super.key,
    this.size = -1,
    required this.title,
    required this.onTap,
    this.isDisabled = false,
  });

  final double size;
  final String title;
  final void Function() onTap;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    double buttonSize =
        size >= 0 ? size : MediaQuery.of(context).size.width * 0.9;

    return GestureDetector(
      onTap: isDisabled ? () {} : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: HexColor(isDisabled ? neutral20 : mariner700),
          borderRadius: BorderRadius.circular(15),
        ),
        width: buttonSize,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11.0, horizontal: 16.0),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: isDisabled ? HexColor(neutral60) : Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
