import 'package:flutter/material.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class InputText extends StatefulWidget {
  const InputText({
    super.key,
    required this.controller,
    this.focusNode,
    this.title,
    this.hintText,
    this.suffixIcon,
    this.confirmPasswordController,
    this.passwordController,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextEditingController? confirmPasswordController;
  final TextEditingController? passwordController;
  final String? title;
  final String? hintText;
  final IconData? suffixIcon;

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title!,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6.0),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty || value.trim().isEmpty) {
              return '${widget.hintText} cannot be empty';
            } else if (widget.title == 'Email' && !value.endsWith('.pens.ac.id')) {
              return 'Invalid email. Use campus email';
            } else if ((widget.title == 'Password' || widget.title == 'New Password') && value.length < 6) {
              return 'Password must be at least 6 characters';
            } else if (widget.title == 'Confirm Password' &&
                widget.passwordController?.text.isNotEmpty == true &&
                value != widget.passwordController!.text) {
              return 'Passwords do not match';
            }
            return null;
          },
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: widget.title == 'Password' ||
                  widget.title == 'Confirm Password' ||
                  widget.title == 'New Password'
              ? _obscureText
              : false,
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
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: HexColor(neutral40),
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
            suffixIcon: widget.suffixIcon != null
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                  )
                : null,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ],
    );
  }
}
