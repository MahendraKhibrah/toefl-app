import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toefl/models/game_data.dart';
import 'package:toefl/models/games/game_detail.dart';
import 'package:toefl/pages/games/games_level_page.dart';
import 'package:toefl/remote/api/game_api.dart';
import 'package:toefl/state_management/quiz/game_provider_state.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/widgets/games/bottom_bar_games.dart';

import '../../routes/route_key.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  late Future<List<Game>> futureGames;

  // late List<Game> _games = [];
  late PageController _pageController;
  late int _index = 0;
  late bool _isActive = false;

  @override
  void initState() {
    super.initState();
    // futureGames = _getGames();
    _pageController = PageController();
    _index = 0;
    _isActive = false;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Future<List<Game>> _getGames() async {
  //   List<Game> temp = await GameApi().fetchGames();
  //   setState(() {
  //     _games = temp;
  //   });
  //   return temp;
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final games = ref.watch(gameProviderStatesProvider);

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: null,
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
            centerTitle: true,
            title: Text(
              'appbar_games'.tr(),
              style: CustomTextStyle.appBarTitle,
            ),
            bottom: BottomBarGames(
              isActive: _isActive,
              preferredSize:
                  _isActive ? Size.fromHeight(100) : Size.fromHeight(60),
              game: games.hasValue
                  ? GameDetail(
                      title: games.value![_index].title,
                      level: games.value![_index].level,
                      description: games.value![_index].description)
                  : GameDetail(
                      title: 'Beginner',
                      level: 1,
                      description: 'You Need Here'),
              onPressed: () {
                setState(() {
                  _isActive = !_isActive;
                });
              },
              currentLevel: _index,
            ),
          ),
          body: games.hasValue
              ? PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: games.valueOrNull!.length,
                  itemBuilder: (context, index) {
                    return GamesLevelPage(
                      quizs: games.valueOrNull![index].gameList!,
                      index: index,
                      isLevelLocked: index > 0
                          ? games.valueOrNull![index - 1].gameList
                                  ?.any((e) => e.gameClaim!.isEmpty) ??
                              false
                          : false,
                    );
                  },
                  onPageChanged: (value) {
                    print(value);
                    setState(() {
                      _index = value;
                    });
                  },
                )
              : Container(),
        );
      },
    );
  }
}
