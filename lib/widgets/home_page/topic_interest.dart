import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toefl/models/quiz.dart';
import 'package:toefl/pages/games/quiz/quiz_page.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class TopicInterest extends StatelessWidget {
  TopicInterest({super.key});

  List<Map<String, dynamic>> topics = [
    {
      "title": "Daily Practice",
      "image": "assets/images/daily_practice.svg",
      "color": "#D0AFFC",
      "onTap": (context) {
        Navigator.pushNamed(context, RouteKey.quiz);
      }
    },
    {
      "title": "Random Quiz",
      "image": "assets/images/random_quiz.svg",
      "color": "#24CE85",
      "onTap": () {
        print("Random Quiz");
      }
    },
    {
      "title": "Vocabulary",
      "image": "assets/images/vocabulary.svg",
      "color": "#FD7366",
      "onTap": () {
        print("Vocabulary");
      }
    },
    {
      "title": "Grammar",
      "image": "assets/images/grammar.svg",
      "color": "#2BBDFB",
      "onTap": () {
        print("Grammar");
      }
    },
    {
      "title": "Listening",
      "image": "assets/images/listening.svg",
      "color": mariner600,
      "onTap": () {
        print("Listening");
      }
    },
    {
      "title": "Reading",
      "image": "assets/images/reading.svg",
      "color": "#FFD93D",
      "onTap": () {
        print("Reading");
      }
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      width: double.infinity,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 24),
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        shrinkWrap: true,
        itemCount: topics.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final topic = topics[index];
          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => topic["onTap"](context),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: HexColor(topic["color"]),
              ),
              margin: EdgeInsets.only(left: 0),
              width: MediaQuery.of(context).size.width / 3,
              child: Padding(
                padding: EdgeInsetsDirectional.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        topic["image"],
                        width: 44,
                        height: 44,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        topic["title"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: HexColor(neutral10)),
                      )
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
