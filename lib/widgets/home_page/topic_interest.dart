import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toefl/models/quiz.dart';
import 'package:toefl/models/quiz_type.dart';
import 'package:toefl/pages/games/practice/word_of_the_day_page.dart';
import 'package:toefl/pages/games/quiz/quiz_page.dart';
import 'package:toefl/remote/api/for_you_api.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class TopicInterest extends StatelessWidget {
  TopicInterest({super.key});

  List<Map<String, dynamic>> topics = [
    {
      "title": "Daily Word",
      "image": "assets/images/daily_practice.svg",
      "decoration": "assets/images/vector_bg_tc1.svg",
      "color": "#BC89FF",
      "background": "#E6D4FF",
    },
    {
      "title": "Random Quiz",
      "image": "assets/images/random_quiz.svg",
      "decoration": "assets/images/vector_bg_tc2.svg",
      "color": "#FF6B84",
      "background": "#FFD6DD",
    },
    {
      "title": "Vocabulary",
      "image": "assets/images/vocabulary.svg",
      "decoration": "assets/images/vector_bg_tc3.svg",
      "color": "#6BB8FF",
      "background": "#D6F0FF",
    },
    {
      "title": "Grammar",
      "image": "assets/images/grammar.svg",
      "decoration": "assets/images/vector_bg_tc4.svg",
      "color": "#5EDEC3",
      "background": "#C9F2E9",
    },
    {
      "title": "Reading",
      "image": "assets/images/reading.svg",
      "decoration": "assets/images/vector_bg_tc5.svg",
      "color": "#8070F8",
      "background": "#C4D0FB",
    },
    {
      "title": "Listening",
      "image": "assets/images/listening.svg",
      "decoration": "assets/images/vector_bg_tc6.svg",
      "color": "#FFC93D",
      "background": "#FFF9C2",
    },
  ];

  Future<List<Quiz>> forYou() async {
    return await ForYouApi().fetchForYou();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      width: double.infinity,
      child: FutureBuilder<List<Quiz>>(
          future: forYou(),
          builder: (context, snapshot) {
            Quiz nullQuiz = Quiz(
                id: '',
                quizName: '',
                quizTypeId: '',
                type: QuizType(id: '', name: '', desc: ''),
                questions: []);
            List<Quiz>? dataForYou = snapshot.data != null ? snapshot.data : [];
            if (dataForYou!.isNotEmpty) {
              dataForYou.insert(0, nullQuiz);
            }
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 24),
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              shrinkWrap: true,
              itemCount: dataForYou.isNotEmpty ? dataForYou.length : 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final quiz =
                    dataForYou.isNotEmpty ? dataForYou[index] : nullQuiz;
                final topic = topics[index];

                return Skeletonizer(
                    enabled:
                        snapshot.connectionState == ConnectionState.waiting,
                    child: Skeleton.leaf(
                        child: index == 0
                            ? WordOfTheDayPage()
                            : ForYouCard(quiz: quiz, topic: topic)));
              },
            );
          }),
    );
  }
}

class ForYouCard extends StatelessWidget {
  const ForYouCard({super.key, required this.topic, required this.quiz});

  final Map<String, dynamic> topic;
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          if (quiz.id != '') {
            Navigator.pushNamed(context, RouteKey.initQuiz, arguments: {
              'id': quiz.id,
              'isGame': false,
              'isReview': false,
            });
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          child: LayoutBuilder(builder: ((context, constraint) {
            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: HexColor(topic["background"]),
                  ),
                  width: constraint.maxHeight / 1,
                ),
                // Positioned(
                //     bottom: -(constraint.maxHeight / 55),
                //     child: SvgPicture.asset(
                //       topic["decoration"],
                //       width: constraint.maxHeight / 1,
                //     )),
                Positioned(
                  top: (constraint.maxHeight / 18),
                  child: Container(
                    width: constraint.maxHeight / 1.8,
                    height: constraint.maxHeight / 1.5,
                    decoration: BoxDecoration(
                      color: HexColor(topic["color"]),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  top: constraint.maxHeight / 4.5,
                  child: SvgPicture.asset(
                    topic["image"],
                    height: constraint.maxHeight / 3,
                  ),
                ),
                Positioned(
                    bottom: constraint.maxHeight / 12,
                    child: Text(
                      topic["title"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: constraint.maxHeight / 8,
                          fontWeight: FontWeight.bold,
                          color: HexColor(topic["color"])),
                    ))
              ],
            );
          })),
        ));
  }
}
