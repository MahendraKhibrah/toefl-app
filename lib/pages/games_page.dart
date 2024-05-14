import 'package:flutter/material.dart';
import 'package:toefl/models/game.dart';
import 'package:toefl/models/games/game_detail.dart';
import 'package:toefl/pages/games/games_level_page.dart';
import 'package:toefl/remote/api/game_api.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/widgets/games/bottom_bar_games.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  late Future<List<Game>> futureGames;

  late PageController _pageController;
  late int _index;
  late bool _isActive;

  @override
  void initState() {
    _pageController = PageController();
    _index = 0;
    _isActive = false;
    futureGames = GameApi().fetchGames();
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
          preferredSize: _isActive ? Size.fromHeight(100) : Size.fromHeight(60),
          game: GameDetail(
              title: 'G',
              level: 1,
              description: 'Hello World LoremIpsum DOor ISmet'),
          onPressed: () {
            setState(() {
              _isActive = !_isActive;
            });
          },
        ),
      ),
      body: FutureBuilder<List<Game>>(
        future: futureGames,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No games available'));
          } else {
            List<Game> games = snapshot.data!;
            return PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: games.length,
              itemBuilder: (context, index) {
                return GamesLevelPage();
              },
              onPageChanged: (value) {
                print(value);
                setState(() {
                  // Update any state you need here
                });
              },
            );
          }
        },
      ),
    );
  }
}
