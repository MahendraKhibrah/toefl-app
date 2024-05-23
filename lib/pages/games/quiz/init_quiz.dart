import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/state_management/quiz/quiz_provider_state.dart';

class InitQuiz extends ConsumerStatefulWidget {
  final String id;
  final bool? isGame;

  const InitQuiz({super.key, required this.id, this.isGame = false});

  @override
  InitQuizState createState() => InitQuizState();
}

class InitQuizState extends ConsumerState<InitQuiz> {
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final test = ref.read(quizGamesProvider.notifier).getClaim(widget.id, true);
  }

  @override
  Widget build(BuildContext context) {
    final quizGameState = ref.watch(quizGamesProvider); // delay parah :"

    quizGameState.when(
      data: (quizGame) {
        if (!_hasNavigated && quizGame.id.isNotEmpty) {
          setState(() {
            _hasNavigated = true;
          });
          Future.delayed(Duration(seconds: 3)).then((_) {
            Navigator.pushNamed(
              context,
              RouteKey.quiz,
              arguments: {'quizGame': quizGame},
            );
          });
        }
      },
      loading: () => Center(
        child: Lottie.network(
          'https://lottie.host/ea511cd5-aff2-4aa6-b104-7f271ecbaca4/LdKLEzRvXf.json',
        ),
      ),
      error: (error, stackTrace) => Center(
        child: Lottie.network(
          'https://lottie.host/ea511cd5-aff2-4aa6-b104-7f271ecbaca4/LdKLEzRvXf.json',
        ),
      ),
    );

    return Scaffold(
      body: Center(
        child: Lottie.network(
          'https://lottie.host/ea511cd5-aff2-4aa6-b104-7f271ecbaca4/LdKLEzRvXf.json',
        ),
      ),
    );
  }
}
