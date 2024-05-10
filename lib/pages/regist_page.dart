import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toefl/models/regist.dart';
import 'package:toefl/remote/api/regist_api.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_button.dart';
import 'package:toefl/widgets/form_input.dart';

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

  @override
  Widget build(BuildContext context) {
    final registApi = RegistApi();
    Regist? regist;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset('assets/images/register.svg'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Create New Account",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: HexColor(mariner700),
                      ),
                    ),
                    Text(
                      "Create a profile to save your account. Go regist and enjoy it!",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: HexColor(neutral50),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputText(
                            controller: nameController,
                            title: "Name",
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
                            title: "Confirm Password",
                            hintText: "Confirm Password",
                            suffixIcon: Icons.visibility_off,
                            passwordController: passwordController,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    BlueButton(
                      title: 'Sign Up',
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          regist = await registApi.postRegist(nameController.text, emailController.text, passwordController.text, confirmPasswordController.text);
                        }
                      },
                    ),
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            color: HexColor(neutral50),
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RouteKey.login);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
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

