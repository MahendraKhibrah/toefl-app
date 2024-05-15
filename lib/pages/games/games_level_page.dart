import 'package:flutter/material.dart';
import 'package:toefl/models/game_data.dart';
import 'package:toefl/models/quiz.dart';
import 'package:toefl/widgets/games/game_button.dart';

class GamesLevelPage extends StatelessWidget {
  final List<GameList> quizs;

  const GamesLevelPage({Key? key, required this.quizs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: buildGameButton(context, quizs[0], 1),
          ),
          Expanded(
            child: buildGameButton(context, quizs[1], 2),
          ),
          Expanded(
            child: buildGameButton(context, quizs[2], 3),
          ),
          Expanded(
            child: buildGameButton(context, quizs[3], 4),
          ),
        ],
      ),
    );
  }

  Widget buildGameButton(BuildContext context, GameList game, int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: MediaQuery.of(context).size.width /
                8 *
                (index % 2 == 0 ? 5 : 1),
            bottom: 10,
            child: GameButton(
              quiz: game.quiz,
            ),
          ),
        ],
      ),
    );
  }
}
