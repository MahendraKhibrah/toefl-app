import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toefl/pages/games/practice/pairing_game.dart';
import 'package:toefl/pages/games/practice/scrambled_word.dart';
import 'package:toefl/pages/games/practice/word_of_the_day_page.dart';
import 'package:toefl/pages/template_page.dart';
import 'package:toefl/remote/api/scrambled_word_api.dart';
import 'package:toefl/remote/local/shared_pref/test_shared_preferences.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/home_page/estimated_score.dart';
import 'package:toefl/widgets/home_page/featured_test.dart';
import 'package:toefl/widgets/home_page/learning_path.dart';
import 'package:toefl/widgets/home_page/simulation_test.dart';
import 'package:toefl/widgets/home_page/topic_interest.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TestSharedPreference _testSharedPref = TestSharedPreference();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    final fullTestStatus = await _testSharedPref.getStatus();
    if (fullTestStatus != null && mounted) {
      Navigator.of(context).pushNamed(RouteKey.openingLoadingTest, arguments: {
        "id": fullTestStatus.id,
        "isRetake": fullTestStatus.isRetake,
        "packetName": fullTestStatus.name
      });
    }

    final miniTestStatus = await _testSharedPref.getMiniStatus();
    if (miniTestStatus != null && mounted) {
      Navigator.of(context).pushNamed(RouteKey.openingMiniTest, arguments: {
        "id": miniTestStatus.id,
        "isRetake": miniTestStatus.isRetake,
        "packetName": miniTestStatus.name
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          titleSpacing: 0,
          title: Padding(
            padding: EdgeInsets.only(left: 24.0),
            child: Text(
              'appbar_home'.tr(),
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 24.0),
              child: Container(
                width: 50,
                height: 50,
                child: Ink(
                    child: IconButton(
                  icon: Ink(
                      decoration: BoxDecoration(
                        color: HexColor(mariner100),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: IconButton(
                          icon: Icon(
                            Icons.bookmarks,
                            color: HexColor(mariner900),
                            size: 18,
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RouteKey.bookmarkedpage);
                          })),
                  onPressed: () {},
                )),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EstimatedScoreWidget(),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'for_you'.tr(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HexColor(neutral90)),
                    ),
                    Text(
                      'topic_interest'.tr(),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: HexColor(neutral50)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TopicInterest(),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Featured",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HexColor(neutral90)),
                    ),
                    Text(
                      "Challenge your knowledge",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: HexColor(neutral50)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              FeatureTest(),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'simulation_test'.tr(),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: HexColor(neutral90)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SimulationTestWidget(),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'learning_path'.tr(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HexColor(neutral90)),
                    ),
                    Text(
                      'part_toefl'.tr(),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: HexColor(neutral50)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              LearningPath(),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }
}
