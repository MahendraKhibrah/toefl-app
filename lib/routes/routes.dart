import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:toefl/pages/full_test/full_test_page.dart';
import 'package:toefl/pages/full_test/simulation_page.dart';
import 'package:toefl/pages/full_test/test_result_page.dart';
import 'package:toefl/pages/login_page.dart';
import 'package:toefl/pages/regist_page.dart';
import 'package:toefl/pages/template_page.dart';
import 'package:toefl/routes/route_key.dart';

final routes = <String, Widget Function(BuildContext)>{
  RouteKey.root: (context) => const TemplatePage(),
  RouteKey.fullTest: (context) => const FullTestPage(),
  RouteKey.regist: (context) => const RegistPage(),
  RouteKey.login: (context) => const LoginPage(),
  RouteKey.simulationpage: (context) => const SimulationPage(),
  RouteKey.testresult: (context) => const TestResultPage(),

};
