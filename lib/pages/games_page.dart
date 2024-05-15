import 'package:flutter/material.dart';
import 'package:toefl/models/game.dart';
import 'package:toefl/pages/games/games_level_page.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/widgets/games/bottom_bar_games.dart';

import '../routes/route_key.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  late PageController _pageController;
  late int _index;
  late bool _isActive;

  @override
  void initState() {
    _pageController = PageController();
    _index = 0;
    _isActive = false;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Padding(
            padding: EdgeInsets.only(top: 30, bottom: 20),
            child: Center(
              child: Text(
                'Games',
                style: CustomTextStyle.appBarTitle,
              ),
            ),
          ),
          bottom: BottomBarGames(
            isActive: _isActive,
            preferredSize:
                _isActive ? Size.fromHeight(100) : Size.fromHeight(60),
            game: Game(
                id: 1,
                level: 1,
                description: 'Hello World LoremIpsum DOor ISmet'),
            onPressed: () {
              setState(() {
                // _isActive = !_isActive;
                Navigator.pushNamed(context, RouteKey.simulationpage);
              });
            },
          ),
        ),
        body: PageView(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          children: [GamesLevelPage(), GamesLevelPage(), Text('1')],
          onPageChanged: (value) {
            print(value);
            setState(() {
              _index = value;
            });
          },
        ));
  }
}
