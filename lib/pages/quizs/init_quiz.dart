import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/state_management/quiz/quiz_provider_state.dart';

class InitQuiz extends ConsumerStatefulWidget {
  final String quizId;
  const InitQuiz({super.key, required this.quizId});

  @override
  InitQuizState createState() => InitQuizState();
}

class InitQuizState extends ConsumerState<InitQuiz> {
  @override
  void initState() {
    super.initState();
    // init();
  }

  Future<void> init() async {
    final state = ref
        .read(quizProviderStateNotifierProvider(widget.quizId).notifier)
        .isRetake('id');

    // state.isRetake(id)

    Future.delayed(Duration(seconds: 4)).then((value) => Navigator.pushNamed(
        context, RouteKey.quiz,
        arguments: {'quizId': widget.quizId}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.network(
            'https://lottie.host/ea511cd5-aff2-4aa6-b104-7f271ecbaca4/LdKLEzRvXf.json'),
      ),
    );
  }
}
