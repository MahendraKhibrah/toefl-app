import 'package:flutter/cupertino.dart';
import 'package:toefl/pages/games/init_game.dart';
import 'package:toefl/pages/grammar_page.dart';
import 'package:toefl/pages/quizs/quiz_page.dart';
import 'package:toefl/pages/edit_profile_page.dart';
import 'package:toefl/pages/full_test/opening_loading_page.dart';
import 'package:toefl/pages/profile_page.dart';
import 'package:toefl/pages/full_test/full_test_page.dart';
import 'package:toefl/pages/full_test/simulation_page.dart';
import 'package:toefl/pages/full_test/test_result_page.dart';
import 'package:toefl/pages/login_page.dart';
import 'package:toefl/pages/on_boarding.dart';
import 'package:toefl/pages/regist_page.dart';
import 'package:toefl/pages/games_page.dart';
import 'package:toefl/pages/setgoal_page.dart';
import 'package:toefl/pages/splash_page.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/pages/main_page.dart';

final routes = <String, Widget Function(BuildContext)>{
  // RouteKey.grammar: (context) => const GrammarPage(),
  RouteKey.quiz: (context) {
    final Map<String, dynamic>? data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return QuizPage(
      quizId: data?["quizId"] ?? "",
    );
  },
  // RouteKey.initQuiz: (context) {
  //   final Map<String, dynamic>? data =
  //       ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
  //   return InitQuiz(
  //     quizId: data?["quizId"] ?? "",
  //   );
  // },
  RouteKey.root: (context) => const SplashPage(),
  RouteKey.main: (context) => const MainPage(),
  RouteKey.fullTest: (context) {
    final Map<String, dynamic>? data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return FullTestPage(
      diffInSec: data?["diffInSeconds"] ?? 0,
      isRetake: data?["isRetake"] ?? false,
    );
  },
  RouteKey.regist: (context) => const RegistPage(),
  RouteKey.login: (context) => const LoginPage(),
  RouteKey.setGoal: (context) => const SetGoal(),
  RouteKey.onBoarding: (context) => const OnBoarding(),
  RouteKey.simulationpage: (context) => const SimulationPage(),
  RouteKey.testresult: (context) => const TestResultPage(),
  RouteKey.profile: (context) => const ProfilePage(),
  RouteKey.editProfile: (context) => EditProfile(),
  RouteKey.gamepage: (context) => const GamesPage(),
  RouteKey.openingLoadingTest: (context) {
    final Map<String, dynamic>? data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return OpeningLoadingPage(
      packetId: data?["id"] ?? "",
      isRetake: data?["isRetake"] ?? false,
      packetName: data?["packetName"] ?? "",
    );
  },
};
