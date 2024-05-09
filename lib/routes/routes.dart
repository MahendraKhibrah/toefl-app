import 'package:flutter/cupertino.dart';
import 'package:toefl/pages/template_page.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/widgets/navbar_bottom.dart';

final routes = <String, Widget Function(BuildContext)>{
  RouteKey.root: (context) => const NavBarBottom(),
};
