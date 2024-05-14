import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/hex_color.dart';

class BlueContainer extends StatelessWidget {
  const BlueContainer({
    super.key,
    required this.child,
    this.width,
    this.showShadow = false,
    this.padding = 16,
    this.color = mariner100,
    this.innerShadow = false,
  });

  final double? width;
  final double padding;
  final bool showShadow;
  final bool innerShadow;
  final Widget child;
  final String color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: innerShadow ? Colors.transparent : HexColor(mariner100),
          borderRadius: BorderRadius.circular(15),
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
              spreadRadius: -1.5,
              blurRadius: 3.0,
              offset: const Offset(0, 1),
            ),
          ]),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: child,
      ),
    );
  }
}
