import 'package:flutter/cupertino.dart';
import 'package:toefl/pages/splash_page.dart';
import 'package:toefl/routes/route_key.dart';

final routes = <String, Widget Function(BuildContext)>{
  RouteKey.root: (context) => const SplashPage(),
};