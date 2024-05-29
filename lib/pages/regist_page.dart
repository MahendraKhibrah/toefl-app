import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toefl/models/auth_status.dart';
import 'package:toefl/models/regist.dart';
import 'package:toefl/remote/local/shared_pref/onboarding_shared_preferences.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_button.dart';
import 'package:toefl/widgets/form_input.dart';

import '../remote/api/user_api.dart';

class RegistPage extends StatefulWidget {
  const RegistPage({super.key});

  @override
  State<RegistPage> createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final userApi = UserApi();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/images/register.svg',
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'create_account',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: HexColor(mariner700),
                      ),
                    ).tr(),
                    Text(
                      'create_account_paragraph',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: HexColor(neutral50),
                      ),
                    ).tr(),
                    const SizedBox(height: 15.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputText(
                            controller: nameController,
                            title: 'label_name'.tr(),
                            hintText: "Name",
                          ),
                          const SizedBox(height: 15.0),
                          InputText(
                            controller: emailController,
                            title: "Email",
                            hintText: "Email",
                          ),
                          const SizedBox(height: 15.0),
                          InputText(
                            controller: passwordController,
                            title: "Password",
                            hintText: "Password",
                            suffixIcon: Icons.visibility_off,
                          ),
                          const SizedBox(height: 15.0),
                          InputText(
                            controller: confirmPasswordController,
                            title: 'confirm_password'.tr(),
                            hintText: "Confirm Password",
                            suffixIcon: Icons.visibility_off,
                            passwordController: passwordController,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    if (isLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      BlueButton(
                        title: 'btn_register'.tr(),
                        onTap: () async {
                          final OnBoardingSharedPreference
                              onBoardingSharedPreference =
                              OnBoardingSharedPreference();
                          final String targetId =
                              await onBoardingSharedPreference
                                  .getTargetIdUser();
                          setState(() {
                            isLoading = true;
                          });
                          final AuthStatus val;
                          if (_formKey.currentState!.validate()) {
                            val = await userApi.postRegist(
                              Regist(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  passwordConfirmation:
                                      confirmPasswordController.text,
                                  targetId: targetId),
                            );
                            Navigator.pushNamed(
                                context, RouteKey.otpVerification, arguments: {
                              'isForgotOTP': false,
                              'email': emailController.text
                            });
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                      ),
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'have_account'.tr(),
                          style: TextStyle(
                            color: HexColor(neutral50),
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.popAndPushNamed(context, RouteKey.login);
                          },
                          child: Text(
                            'login_link'.tr(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
