import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:toefl/pages/games/practice/scrambled_sentence.dart';
import 'package:toefl/pages/games/practice/testing.dart';
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
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'appbar_home'.tr(),
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w800),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            child: Ink(
                                decoration: BoxDecoration(
                                  color: HexColor('D4EFFF'),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: IconButton(
                                    highlightColor: Colors.transparent,
                                    icon: Icon(
                                      Icons.bookmarks,
                                      color: HexColor(mariner900),
                                      size: 18,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(RouteKey.bookmarkedpage);
                                    })),
                          )
                        ],
                      ),
                    ),
                    EstimatedScoreWidget(),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
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
                height: 15,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'simulation_test'.tr(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: HexColor(neutral90)),
                      ),
                      Text(
                        "Try a similar TOEFL test here",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: HexColor(neutral50)),
                      ),
                    ],
                  )),
              SizedBox(
                height: 15,
              ),
              SimulationTestWidget(),
              SizedBox(
                height: 15,
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
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SentenceScramblePage(),
                    ));
                  },
                  child: Text('test'))
            ],
          ),
        )));
  }
}
