import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/hex_color.dart';

class BlueContainer extends StatelessWidget {
  const BlueContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.showShadow = false,
    this.padding = 16,
    this.color = mariner100,
    this.innerShadow = false,
    this.borderRadius = 15,
    this.colorOpacity,
  });

  final double? width;
  final double? height;
  final double padding;
  final bool showShadow;
  final bool innerShadow;
  final Widget child;
  final String color;
  final double borderRadius;
  final double? colorOpacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * 0.9,
      height: height,
      decoration: BoxDecoration(
          color: innerShadow
              ? Colors.transparent
              : HexColor(color).withOpacity(colorOpacity ?? 1.0),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(showShadow ? 0.5 : 0),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(innerShadow ? 0.3 : 0),
            ),
            BoxShadow(
              color: innerShadow ? HexColor(color) : Colors.transparent,
              spreadRadius: -0.5,
              blurRadius: 1.0,
              // offset: const Offset(0, 1),
            ),
          ]),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: child,
      ),
    );
  }
}
