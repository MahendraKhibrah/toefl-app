import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toefl/remote/local/shared_pref/onboarding_shared_preferences.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_button.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/images/onboarding.svg',
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 56),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to Our App",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: HexColor(mariner700)),
                  ),
                  Text(
                    "Learn the words of language, grammar, conversation and reading",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: HexColor(neutral50),
                    ),
                  ),
                  const SizedBox(height: 75),
                  BlueButton(
                      title: 'Next',
                      onTap: () async {
                        final OnBoardingSharedPreference
                            onBoardingSharedPreference =
                            OnBoardingSharedPreference();

                        onBoardingSharedPreference.setOnboardingFalse();
                        Navigator.popAndPushNamed(context, RouteKey.login);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
