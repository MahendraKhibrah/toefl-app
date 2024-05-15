import 'package:flutter/material.dart';
import 'package:toefl/models/quiz_question.dart';
import 'package:toefl/widgets/answer_button.dart';
import 'package:toefl/widgets/answer_validation_container.dart';
import 'package:toefl/widgets/blue_button.dart';
import 'package:toefl/widgets/blue_container.dart';
import 'package:toefl/widgets/next_button.dart';

class GrammarPage extends StatefulWidget {
  final QuizQuestion question;
  const GrammarPage({
    super.key,
    required this.question,
  });

  @override
  State<GrammarPage> createState() => _GrammarPageState();
}

class _GrammarPageState extends State<GrammarPage> {
  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController(initialPage: 0);
    var selectedIndex = 0;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: BlueContainer(
                  child: Text(widget.question.content!.first.content),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10, top: 20, bottom: 10),
                child: const Text(
                  "Fill the blanks using suitable words!",
                  textAlign: TextAlign.left,
                ),
              ),
              ...List.generate(
                  widget.question.content!.first.options!.length,
                  (indexList) => Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10),
                        child: AnswerButton(
                          isAnswerTrue: true,
                          onTap: () {
                            setState(() {
                              selectedIndex = indexList;
                            });
                          },
                          title: widget.question.content!.first
                              .options![indexList].options,
                          isActive: selectedIndex == indexList,
                        ),
                      )),
              AnswerValidationContainer(
                isCorrect: true,
                keyAnswer:
                    widget.question.content!.first.answerKey.option.options,
                explanation:
                    widget.question.content!.first.answerKey.explanation,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
