import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toefl/models/test/packet_detail.dart';

import '../../state_management/full_test_provider.dart';
import '../../widgets/answer_button.dart';

class MultipleChoices extends ConsumerStatefulWidget {
  const MultipleChoices({super.key, required this.question});

  final Question question;

  @override
  ConsumerState<MultipleChoices> createState() => _MultipleChoicesState();
}

class _MultipleChoicesState extends ConsumerState<MultipleChoices> {
  var selectedAnswer = "";
  var choices = [];

  @override
  void initState() {
    super.initState();
    selectedAnswer = widget.question.answer;
    choices = widget.question.choices;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(4, (index) {
        return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: AnswerButton(
                onTap: () {
                  setState(() {
                    if (choices.length >= 4) {
                      if (selectedAnswer != choices[index].choice) {
                        EasyDebounce.debounce("multiple_choices",
                            const Duration(milliseconds: 500), () {
                          ref.read(fullTestProvider.notifier).updateAnswer(
                              widget.question.number, selectedAnswer);
                        });
                      }
                      selectedAnswer = choices[index].choice;
                    }
                  });
                },
                title:
                    "(${String.fromCharCode(65 + index)})  ${choices.length >= 4 ? choices[index].choice : "Choice $index"}",
                isActive: choices.length >= 4
                    ? selectedAnswer == choices[index].choice
                    : false));
      }),
    );
  }
}
