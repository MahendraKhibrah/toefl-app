import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toefl/routes/navigator_key.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/routes/route_observer.dart';
import 'package:toefl/routes/routes.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:toefl/utils/locale.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale(LocaleEnum.id.name),
        Locale(LocaleEnum.en.name),
      ],
      path: 'assets/translation',
      fallbackLocale: Locale(LocaleEnum.id.name),
      child: const ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: Locale(Platform.localeName),
      title: 'Pentol',
      theme: ThemeData(
        primaryColor: HexColor(mariner700),
        secondaryHeaderColor: HexColor(mariner100),
        fontFamily: GoogleFonts.nunito().fontFamily,
      ),
      initialRoute: RouteKey.root,
      routes: routes,
      navigatorKey: navigatorKey,
      navigatorObservers: [
        NavigatorHistory(),
      ],
    );
  }
}
