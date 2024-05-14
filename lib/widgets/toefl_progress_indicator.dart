import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/hex_color.dart';

class ToeflProgressIndicator extends StatelessWidget {
  const ToeflProgressIndicator({
    super.key,
    this.size = 100,
    this.strokeWidth = 20,
    required this.value,
    this.scale = 1,
    this.activeHexColor = mariner300,
    this.nonActiveHexColor = neutral20,
    this.strokeScaler = 1.0,
  });

  final double size;
  final double strokeWidth;
  final double value;
  final double scale;
  final String activeHexColor;
  final String nonActiveHexColor;
  final double strokeScaler;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.rotate(
            angle: -0.3 * strokeScaler,
            child: Transform.scale(
              scaleX: -1,
              child: SizedBox(
                height: size,
                width: size,
                child: CircularProgressIndicator(
                  value: 1 - value - (0.09 * strokeScaler),
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      HexColor(nonActiveHexColor)),
                  strokeWidth: strokeWidth,
                  strokeCap: StrokeCap.round,
                ),
              ),
            ),
          ),
          Transform.rotate(
            angle: 0.2 * strokeScaler,
            child: SizedBox(
              height: size,
              width: size,
              child: CircularProgressIndicator(
                value: value - (0.07 * strokeScaler),
                backgroundColor: Colors.transparent,
                valueColor:
                    AlwaysStoppedAnimation<Color>(HexColor(activeHexColor)),
                strokeWidth: strokeWidth,
                strokeCap: StrokeCap.round,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
