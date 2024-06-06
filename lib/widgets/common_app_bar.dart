import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;
  final Color? backgroundColor;
  final bool? withBack;
  final List<Widget>? actions;
  const CommonAppBar({
    super.key,
    this.height = kToolbarHeight,
    required this.title,
    this.backgroundColor = Colors.white,
    this.withBack = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: withBack!
          ? IconButton(
              icon: Icon(
                Icons.chevron_left_rounded,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      title: Text(
        title,
        style: GoogleFonts.nunito(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: HexColor(neutral90)),
      ),
      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}
