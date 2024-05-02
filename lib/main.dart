import 'package:flutter/material.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/routes/routes.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pentol',
      theme: ThemeData(
        primaryColor: HexColor(mariner700),
        secondaryHeaderColor: HexColor(mariner100),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(primary: HexColor(mariner700))
            .copyWith(secondary: HexColor(mariner100)),
        fontFamily: GoogleFonts.nunito().fontFamily,
      ),
      initialRoute: RouteKey.root,
      routes: routes,

    );
  }
}
