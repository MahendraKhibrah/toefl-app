import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/games/game_button.dart';

class GamesLevelPage extends StatefulWidget {
  const GamesLevelPage({super.key});

  @override
  State<GamesLevelPage> createState() => _GamesLevelPageState();
}

class _GamesLevelPageState extends State<GamesLevelPage> {
  final keyComponent = GlobalKey();

  // late Size size;
  // late Offset position;

  // void getCurr() => WidgetsBinding.instance.addPostFrameCallback((_) {
  //       final RenderBox? box =
  //           keyComponent.currentContext!.findRenderObject() as RenderBox?;

  //     });

  // @override
  // void initState() {
  //   getCurr();
  //   si
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: keyComponent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1, // you can play with this value, by default it is 1
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: MediaQuery.of(context).size.width / 8 * 1,
                    bottom: 10,
                    child: GameButton(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1, // you can play with this value, by default it is 1
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: MediaQuery.of(context).size.width / 8 * 5,
                    bottom: 10,
                    child: GameButton(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1, // you can play with this value, by default it is 1
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: MediaQuery.of(context).size.width / 8 * 1,
                    bottom: 10,
                    child: GameButton(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1, // you can play with this value, by default it is 1
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: MediaQuery.of(context).size.width / 8 * 5,
                    bottom: 10,
                    child: GameButton(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
