import 'package:flutter/material.dart';
import 'package:toefl/pages/games/quiz/grammar_page.dart';
import 'package:toefl/widgets/games/quiz/step_progress.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController(initialPage: 0);
    double _currentPage = 0;

    @override
    void initState() {
      super.initState();
      _controller.addListener(() {
        setState(() {
          _currentPage = _controller.page!;
        });
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: StepProgress(currentStep: _currentPage, steps: 6),
            ),
            Expanded(
                child: PageView(
              controller: _controller,
              children: [
                GrammarPage(),
                GrammarPage(),
                GrammarPage(),
                GrammarPage(),
                GrammarPage(),
                GrammarPage(),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
