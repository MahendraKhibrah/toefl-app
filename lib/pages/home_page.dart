import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toefl/remote/local/shared_pref/test_shared_preferences.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/home_page/estimated_score.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          titleSpacing: 0,
          title: Padding(
            padding: EdgeInsets.only(left: 24),
            child: Text(
              'Start Learning Today!',
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
                      child: IconButton(
                          icon: Icon(
                            Icons.bookmarks,
                            color: HexColor(mariner900),
                            size: 18,
                          ),
                          onPressed: null),
                      decoration: BoxDecoration(
                        color: HexColor(mariner100),
                        borderRadius: BorderRadius.circular(6.0),
                      )),
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
              EstimatedScore(),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "For You",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HexColor(neutral90)),
                    ),
                    Text(
                      "Based on your topic interest",
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
                child: Text(
                  "Simulation Test",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: HexColor(neutral90)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SimulationTest()
            ],
          ),
        ));
  }
}
