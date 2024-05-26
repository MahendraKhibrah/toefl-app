import 'package:flutter/material.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_button.dart';
import 'package:toefl/widgets/form_input.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  late final FocusNode _passwordFocusNode;
  late final FocusNode _confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          borderRadius: BorderRadius.circular(40),
          child: const Icon(
            Icons.chevron_left_rounded,
            size: 30,
          ),
          onTap: () {
            Navigator.popAndPushNamed(context, RouteKey.otpVerification);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "Create New Password",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            color: HexColor(neutral70),
                          ),
                          children: const [
                            TextSpan(
                              text:
                                  "Your password should be different from teh previous password.",
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputText(
                            controller: passwordController,
                            title: "New Password",
                            hintText: "New Password",
                            suffixIcon: Icons.visibility_off,
                            focusNode: _passwordFocusNode,
                          ),
                          const SizedBox(height: 15.0),
                          InputText(
                            controller: confirmPasswordController,
                            title: "Confirm Password",
                            hintText: "Confirm Password",
                            suffixIcon: Icons.visibility_off,
                            passwordController: passwordController,
                            focusNode: _confirmPasswordFocusNode,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            BlueButton(
                title: "Reset Password",
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.popAndPushNamed(
                        context, RouteKey.successPassword);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
