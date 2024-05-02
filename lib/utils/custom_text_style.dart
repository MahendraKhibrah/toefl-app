import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyle {
  CustomTextStyle._();

  static TextStyle bold16 = GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static TextStyle light13 = GoogleFonts.nunito(
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );

  static TextStyle extraBold16 = GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w900,
  );

  static TextStyle normal12 = GoogleFonts.nunito(
    fontSize: 12,
  );
}
