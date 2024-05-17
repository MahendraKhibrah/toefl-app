import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toefl/models/test/packet_detail.dart';
import 'package:toefl/state_management/mini_test_provider.dart';
import 'package:toefl/widgets/answer_button.dart';

class MiniMultipleChoices extends ConsumerStatefulWidget {
  const MiniMultipleChoices({super.key, required this.question});

  final Question question;

  @override
  ConsumerState<MiniMultipleChoices> createState() => _MultipleChoicesState();
}

class _MultipleChoicesState extends ConsumerState<MiniMultipleChoices> {
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
            child: Skeleton.replace(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: AnswerButton(
                  onTap: () {
                    setState(() {
                      if (choices.length >= 4) {
                        if (selectedAnswer != choices[index].choice) {
                          EasyDebounce.debounce("multiple_choices",
                              const Duration(milliseconds: 500), () {
                            ref.read(miniTestProvider.notifier).updateAnswer(
                                widget.question.number, selectedAnswer);
                          });
                        }
                        selectedAnswer = choices[index].choice;
                      }
                    });
                  },
                  title:
                      "(${String.fromCharCode(65 + index)})  ${choices.length >= 4 ? choices[index].choice : ""}",
                  isActive: choices.length >= 4
                      ? selectedAnswer == choices[index].choice
                      : false),
            ));
      }),
    );
  }
}
