import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:toefl/pages/grammar_page.dart';
import 'package:toefl/pages/quiz_page.dart';
import 'package:toefl/pages/edit_profile_page.dart';
import 'package:toefl/pages/full_test/opening_loading_page.dart';
import 'package:toefl/pages/profile_page.dart';
import 'package:toefl/pages/full_test/full_test_page.dart';
import 'package:toefl/pages/full_test/simulation_page.dart';
import 'package:toefl/pages/full_test/test_result_page.dart';
import 'package:toefl/pages/login_page.dart';
import 'package:toefl/pages/regist_page.dart';
import 'package:toefl/pages/games_page.dart';
import 'package:toefl/pages/splash_page.dart';
import 'package:toefl/pages/template_page.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/pages/main_page.dart';

final routes = <String, Widget Function(BuildContext)>{
  RouteKey.grammar: (context) => const GrammarPage(),
  RouteKey.quiz: (context) => const QuizPage(),
  RouteKey.root: (context) => const SplashPage(),
  RouteKey.main: (context) => const MainPage(),
  RouteKey.fullTest: (context) {
    final int? seconds = ModalRoute.of(context)?.settings.arguments as int?;
    return FullTestPage(seconds ?? 0);
  },
  RouteKey.regist: (context) => const RegistPage(),
  RouteKey.login: (context) => const LoginPage(),
  RouteKey.simulationpage: (context) => const SimulationPage(),
  RouteKey.testresult: (context) => const TestResultPage(),
  RouteKey.profile: (context) => const ProfilePage(),
  RouteKey.editProfile: (context) => EditProfile(),
  RouteKey.openingLoadingTest: (context) => const OpeningLoadingPage(),
};
