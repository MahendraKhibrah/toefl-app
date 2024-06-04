import 'package:flutter/cupertino.dart';
import 'package:toefl/models/games/user_rank.dart';
import 'package:toefl/models/quiz.dart';
import 'package:toefl/models/quiz_type.dart';
import 'package:toefl/pages/games/quiz/finish_quiz_page.dart';
import 'package:toefl/pages/games/quiz/init_quiz.dart';
import 'package:toefl/pages/auth/forgot_password_page.dart';
import 'package:toefl/pages/games/quiz/quiz_page.dart';
import 'package:toefl/pages/bookmark/bookmark_detail_page.dart';
import 'package:toefl/pages/bookmark/bookmarked_page.dart';
import 'package:toefl/pages/full_test/set_target_page.dart';

import 'package:toefl/pages/mini_test/mini_opening_page.dart';
import 'package:toefl/pages/mini_test/mini_simulation_page.dart';
import 'package:toefl/pages/mini_test/mini_test_page.dart';

import 'package:toefl/pages/games/quiz/quiz_page.dart';
import 'package:toefl/pages/user/edit_profile_page.dart';
import 'package:toefl/pages/full_test/opening_loading_page.dart';
import 'package:toefl/pages/auth/new_password_page.dart';
import 'package:toefl/pages/auth/otp_verification_page.dart';
import 'package:toefl/pages/user/profile_page.dart';
import 'package:toefl/pages/full_test/full_test_page.dart';
import 'package:toefl/pages/full_test/simulation_page.dart';
import 'package:toefl/pages/full_test/test_result_page.dart';
import 'package:toefl/pages/auth/login_page.dart';
import 'package:toefl/pages/on_boarding.dart';
import 'package:toefl/pages/rank_page.dart';
import 'package:toefl/pages/auth/regist_page.dart';
import 'package:toefl/pages/games/games_page.dart';
import 'package:toefl/pages/review_test/review_test_page.dart';
import 'package:toefl/pages/user/search_user_page.dart';
import 'package:toefl/pages/user/setgoal_page.dart';
import 'package:toefl/pages/splash_page.dart';
import 'package:toefl/pages/auth/success_password_page.dart';
import 'package:toefl/pages/user/setting_page.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/pages/main_page.dart';
import 'package:toefl/state_management/quiz/quiz_provider_state.dart';

final routes = <String, Widget Function(BuildContext)>{
  // RouteKey.grammar: (context) => const GrammarPage(),
  RouteKey.quiz: (context) {
    final Map<String, dynamic>? data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return QuizPage(
      quizGame: data?['quizGame'] ??
          QuizGame(
            id: '',
            isGame: false,
            userAnswer: [],
            quiz: Quiz(
              id: '',
              questions: [],
              quizName: 'defaultNull',
              quizTypeId: '',
              type: QuizType(id: '', name: '', desc: ''),
            ),
          ),
      isReview: data?['isReview'] ?? false,
    );
  },
  // RouteKey.quiz: (context) => const QuizPage(),
  RouteKey.initQuiz: (context) {
    final Map<String, dynamic>? data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return InitQuiz(
      id: data?["id"] ?? "",
      isGame: data?["isGame"] ?? false,
      isReview: data?["isReview"] ?? false,
    );
  },
  RouteKey.root: (context) => const SplashPage(),
  RouteKey.main: (context) => const MainPage(),
  RouteKey.fullTest: (context) {
    final Map<String, dynamic>? data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    debugPrint("data: $data");
    return FullTestPage(
      diffInSec: data?["diffInSeconds"] ?? 0,
      isRetake: data?["isRetake"] ?? false,
    );
  },
  RouteKey.regist: (context) => const RegistPage(),
  RouteKey.otpVerification: (context) {
    final Map<String, dynamic>? data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return OtpVerification(
      isForgotOTP: data?['isForgotPassword'] ?? false,
      email: data?['email'] ?? "",
    );
  },
  RouteKey.forgotPassword: (context) {
    final String? data = ModalRoute.of(context)?.settings.arguments as String?;
    return ForgotPassword(
      initialEmail: data ?? "",
    );
  },
  RouteKey.resetPassword: (context) {
    final bool? data = ModalRoute.of(context)?.settings.arguments as bool?;
    return NewPassword(
      isAuthenticated: data ?? false,
    );
  },
  RouteKey.successPassword: (context) => const SuccessPassword(),
  RouteKey.login: (context) => const LoginPage(),
  RouteKey.setGoal: (context) => const SetGoal(),
  RouteKey.onBoarding: (context) => const OnBoarding(),
  RouteKey.simulationpage: (context) => const SimulationPage(),
  RouteKey.testresult: (context) {
    final Map? data = ModalRoute.of(context)?.settings.arguments as Map?;
    return TestResultPage(
      packetId: data?["packetId"] ?? "",
      isMiniTest: data?["isMiniTest"] ?? false,
      packetName: data?["packetName"] ?? "",
    );
  },
  RouteKey.profile: (context) {
    final data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return ProfilePage(
      isMe: data?['isMe'] ?? true,
      userId: data?['userId'] ?? "",
    );
  },
  RouteKey.editProfile: (context) => EditProfile(),
  RouteKey.rank: (context) {
    final Map? data = ModalRoute.of(context)?.settings.arguments as Map?;
    return RankPage(
      dataRank: data?["dataRank"] ?? UserRank(userId: ''),
    );
  },
  RouteKey.gamepage: (context) => const GamesPage(),
  RouteKey.bookmarkedpage: (context) => const BookmarkedPage(),
  RouteKey.setTargetPage: (context) => const SetTargetPage(),
  RouteKey.openingLoadingTest: (context) {
    final Map<String, dynamic>? data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return OpeningLoadingPage(
      packetId: data?["id"] ?? "",
      isRetake: data?["isRetake"] ?? false,
      packetName: data?["packetName"] ?? "",
    );
  },
  RouteKey.reviewTestPage: (context) {
    final Map? data = ModalRoute.of(context)?.settings.arguments as Map?;
    return ReviewTestPage(
      packetId: data?['packetId'] ?? "",
      isFull: data?['isFull'] ?? false,
    );
  },
  RouteKey.openingMiniTest: (context) {
    final Map<String, dynamic>? data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return MiniOpeningPage(
      packetId: data?["id"] ?? "",
      isRetake: data?["isRetake"] ?? false,
      packetName: data?["packetName"] ?? "",
    );
  },
  RouteKey.miniTest: (context) {
    final Map<String, dynamic>? data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    debugPrint("data: $data");
    return MiniTestPage(
      diffInSec: data?["diffInSeconds"] ?? 0,
      isRetake: data?["isRetake"] ?? false,
    );
  },
  RouteKey.miniSimulationTest: (context) => const MiniSimulationPage(),
  RouteKey.bookmark: (context) => const BookmarkedPage(),
  RouteKey.bookmarkDetail: (context) {
    final String? data = ModalRoute.of(context)?.settings.arguments as String?;
    return BookmarkDetailPage(bookmarkId: data ?? "");
  },
  RouteKey.finishQuizResult: (context) {
    final Map<String, dynamic>? data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return FinishQuizPage(result: data?["result"] ?? "");
  },
  RouteKey.settingPage: (context) => const SettingPage(),
  RouteKey.searchUser: (context) => const SearchUserPage(),
};
