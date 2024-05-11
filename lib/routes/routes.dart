import 'package:flutter/cupertino.dart';
import 'package:toefl/pages/full_test/full_test_page.dart';
import 'package:toefl/pages/login_page.dart';
import 'package:toefl/pages/regist_page.dart';
import 'package:toefl/pages/games_page.dart';
import 'package:toefl/pages/template_page.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/widgets/navbar_bottom.dart';

final routes = <String, Widget Function(BuildContext)>{
  RouteKey.root: (context) => NavBarBottom(),
  RouteKey.fullTest: (context) => const FullTestPage(),
  RouteKey.regist: (context) => const RegistPage(),
  RouteKey.login: (context) => const LoginPage(),
};
