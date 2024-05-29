import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toefl/remote/local/shared_pref/auth_shared_preferences.dart';

import '../routes/route_key.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final AuthSharedPreference authSharedPreference = AuthSharedPreference();
    final isVerified = await authSharedPreference.getVerifiedAccount();
    await authSharedPreference.getBearerToken().then((value) async {
      final bool isLogin = (value ?? "").isNotEmpty;
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        if (isLogin && isVerified) {
          Navigator.of(context).pushReplacementNamed(RouteKey.main);
        } else {
          Navigator.of(context).pushReplacementNamed(RouteKey.login);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/images/logo.svg',
        ),
      ),
    );
  }
}
