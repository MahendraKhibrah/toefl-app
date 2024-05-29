import 'package:flutter/material.dart';
import 'package:toefl/remote/api/user_api.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_button.dart';
import 'package:toefl/widgets/form_input.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key, this.isAuthenticated = false});

  final bool? isAuthenticated;

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  late final FocusNode _passwordFocusNode;
  late final FocusNode _confirmPasswordFocusNode;

  var isLoading = false;
  UserApi userApi = UserApi();

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
            Navigator.pop(context);
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
                                  "Your password should be different from the previous password.",
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
            isLoading
                ? CircularProgressIndicator(
                    color: HexColor(mariner700),
                  )
                : BlueButton(
                    title: "Reset Password",
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        final isSuccess = await userApi.updatePassword(
                            passwordController.text,
                            confirmPasswordController.text);
                        if (isSuccess) {
                          Navigator.popUntil(context, (route) => route.isFirst);
                          if (!(widget.isAuthenticated ?? true)) {
                            Navigator.pushNamed(
                                context, RouteKey.successPassword);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  const Text("Password must be different!"),
                              backgroundColor: HexColor(colorError),
                            ),
                          );
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }),
          ],
        ),
      ),
    );
  }
}
