import 'package:flutter/cupertino.dart';
import 'package:toefl/pages/edit_profile_page.dart';
import 'package:toefl/pages/profile_page.dart';
import 'package:toefl/pages/template_page.dart';
import 'package:toefl/routes/route_key.dart';

final routes = <String, Widget Function(BuildContext)>{
  RouteKey.root: (context) => const TemplatePage(),
  RouteKey.profile: (context) => const ProfilePage(),
  RouteKey.editProfile: (context) =>  EditProfile(),
};
