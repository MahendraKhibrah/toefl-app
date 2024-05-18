import 'package:flutter/material.dart';
import 'package:toefl/widgets/answer_button.dart';
import 'package:toefl/widgets/answer_validation_container.dart';
import 'package:toefl/widgets/blue_button.dart';
import 'package:toefl/widgets/blue_container.dart';
import 'package:toefl/widgets/next_button.dart';

class GrammarPage extends StatefulWidget {
  const GrammarPage({
    super.key,
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
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: BlueContainer(
                  child: Text("My mother did not ____ rice at my house."),
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
                  5,
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
                          title: 'indexList $indexList',
                          isActive: selectedIndex == indexList,
                        ),
                      )),
              const AnswerValidationContainer(
                isCorrect: true,
                keyAnswer: '(B) Leaving a message',
                explanation:
                    'Because lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              ),
              const SizedBox(
                height: 20,
              ),
              NextButton(pageController: _controller)
            ],
          ),
        ),
      ),
    );
  }
}
