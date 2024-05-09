import 'package:flutter/cupertino.dart';
import 'package:toefl/pages/full_test/full_test_page.dart';
import 'package:toefl/pages/template_page.dart';
import 'package:toefl/routes/route_key.dart';

final routes = <String, Widget Function(BuildContext)>{
  RouteKey.root: (context) => const TemplatePage(),
  RouteKey.fullTest: (context) => const FullTestPage(),
};
