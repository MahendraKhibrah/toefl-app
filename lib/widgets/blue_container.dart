import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/hex_color.dart';

class BlueContainer extends StatelessWidget {
  const BlueContainer(
      {super.key, required this.child, this.width, this.showShadow = false});

  final double? width;
  final bool showShadow;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: HexColor(mariner100),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(showShadow ? 0.5 : 0),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
