import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toefl/models/quiz.dart';
import 'package:toefl/models/quiz_type.dart';
import 'package:toefl/pages/games/quiz/grammar_page.dart';
import 'package:toefl/remote/api/quiz_api.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/state_management/quiz/quiz_provider_state.dart';
import 'package:toefl/widgets/games/quiz/step_progress.dart';
import 'package:toefl/widgets/games/quiz/next_button.dart';
import 'package:toefl/widgets/quiz/modal/modal_confirmation.dart';

class QuizPage extends ConsumerStatefulWidget {
  final bool? isReview;
  final QuizGame quizGame;
  const QuizPage({
    super.key,
    required this.quizGame,
    this.isReview = false,
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
      (outerIndex) =>
          List.generate(quiz.questions![outerIndex].content!.length, (index) {
        for (var ans in widget.quizGame.userAnswer) {
          if (ans.quizContentId ==
              quiz.questions![outerIndex].content![index].id) {
            return ans.quizOptionId;
          }
        }

        return '';
      }),
    );

    print(selectedIndex);
    return quiz;
  }

  Widget _buildQuizPage(Quiz quiz, bool isReview) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return ModalConfirmation(
                  message: 'Are you want to abort?, change saved',
                  leftTitle: 'Nevermind',
                  rightTitle: 'Abort',
                  leftFunction: () => Navigator.of(context).pop(),
                  rightFunction: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil(RouteKey.main, (route) => false),
                );
              },
            ) ??
            false;
        if (context.mounted && shouldPop) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: StepProgress(
            quizType: quiz.type.name,
            currentStep: _currentPage,
            steps: quiz.questions!.length),
        body: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Expanded(
              child: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: _controller,
                itemCount: quiz.questions!.length,
                itemBuilder: (context, index) {
                  return GrammarPage(
                    selectedIndex: selectedIndex[_currentPage],
                    quizGame: widget.quizGame,
                    question: quiz.questions![_currentPage],
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
                isReview: isReview,
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
    return _buildQuizPage(_quizFuture, widget.isReview!);
  }
}
