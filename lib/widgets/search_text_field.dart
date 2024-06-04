import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.focusNode,
    this.hintText,
  });

  final TextEditingController controller;
  final Function(String) onChanged;
  final FocusNode? focusNode;
  final String? hintText;

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: HexColor(mariner700),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10.0,
              ),
              Icon(Icons.search, color: HexColor(neutral90)),
              const Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.67,
                child: TextFormField(
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  onChanged: (value) {
                    setState(() {});
                    EasyDebounce.debounce(
                        'search_debounce', const Duration(milliseconds: 800),
                        () {
                      widget.onChanged(value);
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: HexColor(neutral40),
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 15.0),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (widget.controller.text.isNotEmpty) {
                      widget.controller.text = "";
                    }
                  });
                },
                child: Icon(Icons.close,
                    color: widget.controller.text.isNotEmpty
                        ? HexColor(neutral90)
                        : Colors.transparent),
              ),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
