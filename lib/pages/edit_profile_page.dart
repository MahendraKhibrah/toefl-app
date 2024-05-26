import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_button.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isEmpty || !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  String? validateName(String? value) {
    if (value!.length < 3)
      return 'Name must be more than 2 characters';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: const Icon(
            Icons.chevron_left_rounded,
            size: 30,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Edit Profile"),
      ),
      body: ListView(
        primary: false,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 50,
                    backgroundImage:
                        AssetImage('assets/images/avatar_profile.png'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    splashColor: const Color(0xffE7E7E7).withOpacity(0.3),
                    highlightColor: Colors.transparent,
                    onTap: () {},
                    child: Text(
                      "Change Picture",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: HexColor(mariner600),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _textField(
                          "Name",
                          false,
                          "Adinda Azzahra",
                          validateName,
                          _nameController..text = 'Adinda Azzahra',
                        ),
                        _textField(
                          "Email",
                          true,
                          "dinda@gmail.com",
                          validateEmail,
                          _emailController..text = 'adinda@gmail.com',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BlueButton(
                          title: 'Update',
                          size: 300,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textField(
    String title,
    bool isEmail,
    String hintText,
    String? Function(String?)? validate,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6.0),
          TextFormField(
            inputFormatters: isEmail
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9@a-zA-Z.]")),
                  ]
                : null,
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: HexColor(mariner700)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: HexColor(neutral40),
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
            keyboardType:
                isEmail ? TextInputType.emailAddress : TextInputType.text,
            validator: validate,
          ),
        ],
      ),
    );
  }
}
