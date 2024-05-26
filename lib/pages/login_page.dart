import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toefl/models/login.dart';
import 'package:toefl/remote/api/user_api.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_button.dart';
import 'package:toefl/widgets/form_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  final userApi = UserApi();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/images/login.svg',
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: HexColor(mariner700),
                      ),
                    ),
                    Text(
                      "Hello there, sign in to continue",
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
                            controller: emailController,
                            title: "Email",
                            hintText: "Email",
                            suffixIcon: null,
                            focusNode: _emailFocusNode,
                          ),
                          const SizedBox(height: 15.0),
                          InputText(
                            controller: passwordController,
                            title: "Password",
                            hintText: "Password",
                            suffixIcon: Icons.visibility_off,
                            focusNode: _passwordFocusNode,
                          ),
                          const SizedBox(height: 6.0),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteKey.forgotPassword);
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: HexColor(mariner700),
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : BlueButton(
                            title: 'Login',
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });
                              var val = false;
                              if (_formKey.currentState!.validate()) {
                                val = await userApi.postLogin(
                                  Login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                                if (val) {
                                  Navigator.popAndPushNamed(
                                      context, RouteKey.main);
                                }
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
                          "Don’t have an account? ",
                          style: TextStyle(
                            color: HexColor(neutral50),
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.popAndPushNamed(context, RouteKey.regist);
                          },
                          child: const Text(
                            "Sign Up",
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
