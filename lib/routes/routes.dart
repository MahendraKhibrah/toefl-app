import 'package:flutter/cupertino.dart';
import 'package:toefl/pages/full_test/full_test_page.dart';
import 'package:toefl/pages/login_page.dart';
import 'package:toefl/pages/regist_page.dart';
import 'package:toefl/pages/games_page.dart';
import 'package:toefl/pages/splash_page.dart';
import 'package:toefl/pages/template_page.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/pages/main_page.dart';

final routes = <String, Widget Function(BuildContext)>{
  // TODO : CHANGE ROOT TO SPLASH PAGE
  RouteKey.root: (context) => const SplashPage(),
  RouteKey.main: (context) => const MainPage(),
  RouteKey.fullTest: (context) => const FullTestPage(),
  RouteKey.regist: (context) => const RegistPage(),
  RouteKey.login: (context) => const LoginPage(),
};
