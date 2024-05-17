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

  static TextStyle bold18 = GoogleFonts.nunito(
    fontSize: 18,
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

  static TextStyle semibold12 =
      GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w600);

  static TextStyle bold12 =
      GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.bold);

  static TextStyle regular10 =
      GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w400);

  static TextStyle extrabold24 =
      GoogleFonts.nunito(fontSize: 24, fontWeight: FontWeight.w800);

  static TextStyle gameScoreResult = GoogleFonts.nunito(
      fontSize: 20, fontWeight: FontWeight.bold, color: HexColor(mariner700));

  static TextStyle gameCardTitle = GoogleFonts.nunito(
    fontSize: 18,
    color: HexColor(neutral90),
    fontWeight: FontWeight.bold,
  );

  static TextStyle gameCardScoreSubTitle = GoogleFonts.nunito(
    fontSize: 20,
    color: HexColor(mariner700),
    fontWeight: FontWeight.w900,
  );

  static TextStyle gameCardPredicateSubTitle = GoogleFonts.nunito(
    fontSize: 20,
    color: HexColor(neutral90),
    fontWeight: FontWeight.bold,
  );
  static TextStyle gameCardStartTitle = GoogleFonts.nunito(
    fontSize: 16,
    color: HexColor(neutral10),
    fontWeight: FontWeight.bold,
  );
}
