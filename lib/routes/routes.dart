import 'package:flutter/cupertino.dart';
import 'package:toefl/pages/grammar_page.dart';
import 'package:toefl/pages/quiz_page.dart';
import 'package:toefl/pages/template_page.dart';
import 'package:toefl/routes/route_key.dart';

final routes = <String, Widget Function(BuildContext)>{
  RouteKey.root: (context) => const TemplatePage(),
  RouteKey.grammar: (context) => const GrammarPage(),
  RouteKey.quiz: (context) => const QuizPage(),
};
