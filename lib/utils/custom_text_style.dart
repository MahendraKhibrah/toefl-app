import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

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

  static TextStyle appBarTitle = GoogleFonts.nunito(
    fontSize: 22,
    color: HexColor(neutral90),
    fontWeight: FontWeight.bold,
  );

  static TextStyle gamePartTitle = GoogleFonts.nunito(
    fontSize: 12,
    color: HexColor(mariner50),
    fontWeight: FontWeight.bold,
  );
  
  static TextStyle medium14 = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
}
