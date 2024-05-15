import 'package:flutter/material.dart';
import 'package:toefl/models/quiz.dart';
import 'package:toefl/pages/grammar_page.dart';
import 'package:toefl/remote/api/quiz_api.dart';
import 'package:toefl/widgets/next_button.dart';
import 'package:toefl/widgets/step_progress.dart';

class QuizPage extends StatefulWidget {
  final String quizId;
  const QuizPage({super.key, required this.quizId});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Future<Quiz> _quizFuture;
  late PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    _quizFuture = _fetchQuizData();
  }

  Future<Quiz> _fetchQuizData() async {
    return QuizApi().fetchQuiz(widget.quizId);
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
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: StepProgress(
                    currentStep: _currentPage, steps: quiz.questions!.length),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: quiz.questions!.length,
                  itemBuilder: (context, index) {
                    return GrammarPage(question: quiz.questions![index]);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: NextButton(pageController: _controller),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Quiz>(
      future: _quizFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return _buildQuizPage(snapshot.data!);
        }
      },
    );
  }
}
