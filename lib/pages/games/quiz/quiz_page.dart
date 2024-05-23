import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toefl/models/quiz.dart';
import 'package:toefl/models/quiz_type.dart';
import 'package:toefl/pages/games/quiz/grammar_page.dart';
import 'package:toefl/remote/api/quiz_api.dart';
import 'package:toefl/state_management/quiz/quiz_provider_state.dart';
import 'package:toefl/widgets/games/quiz/step_progress.dart';
import 'package:toefl/widgets/games/quiz/next_button.dart';

class QuizPage extends ConsumerStatefulWidget {
  final QuizGame quizGame;
  const QuizPage({
    super.key,
    required this.quizGame,
  });

  @override
  ConsumerState<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends ConsumerState<QuizPage> {
  late Quiz _quizFuture;
  late PageController _controller;
  int _currentPage = 0;
  List<List<String>> selectedIndex = [];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    _quizFuture = _fetchQuizData();
  }

  Quiz _fetchQuizData() {
    print(widget.quizGame);

    Quiz quiz = widget.quizGame.quiz;

    selectedIndex = List.generate(
      quiz.questions!.length,
      (index) => List.generate(
        quiz.questions![index].content!.length,
        (index) => '',
      ),
    );
    return quiz;
  }

  Widget _buildQuizPage(Quiz quiz) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text(
                    'Are you sure you want to leave this page?',
                  ),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Nevermind'),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Leave'),
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                    ),
                  ],
                );
              },
            ) ??
            false;
        if (context.mounted && shouldPop) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: StepProgress(
                  quizType: quiz.type.name,
                  currentStep: _currentPage,
                  steps: quiz.questions!.length),
            ),
            Expanded(
              child: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: _controller,
                itemCount: quiz.questions!.length,
                itemBuilder: (context, index) {
                  return GrammarPage(
                    quizGame: widget.quizGame,
                    question: quiz.questions![index],
                    setButton: (selectedIndex) =>
                        setButtonState(_currentPage, selectedIndex),
                    quizGameAnswer: widget.quizGame.userAnswer,
                  );
                },
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
              ),
            ),
            // Text(selectedIndex[_currentPage].toString()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: NextButton(
                pageController: _controller,
                isDisabled: selectedIndex[_currentPage].contains(''),
                claimId: widget.quizGame.id,
                isGame: widget.quizGame.isGame,
              ),
            ),
          ],
        ),
      ),
    );
  }

  setButtonState(int row, List<String> index) {
    setState(() {
      selectedIndex[row] = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildQuizPage(_quizFuture);
  }
}
