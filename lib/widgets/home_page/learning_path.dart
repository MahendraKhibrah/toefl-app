import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class LearningPath extends StatelessWidget {
  LearningPath({super.key});

  final List<Map<String, dynamic>> learnings = [
    {
      "title": "Vocabulary",
      "image": "assets/images/vocabulary.svg",
      "course": "2",
      "border": "#6BB8FF",
      "color": "#8FC9FF",
      "background": "#D6F0FF",
      "onTap": () {
        print("Vocabulary");
      }
    },
    {
      "title": "Grammar",
      "image": "assets/images/grammar.svg",
      "course": "2",
      "border": "#5EDEC3",
      "color": "#84E6D1",
      "background": "#C9F2E9",
      "onTap": () {
        print("Grammar");
      }
    },
    {
      "title": "Reading",
      "image": "assets/images/reading.svg",
      "course": "2",
      "border": "#6A5AE0",
      "color": "#9087E5",
      "background": "#C4D0FB",
      "onTap": () {
        print("Reading");
      }
    },
    {
      "title": "Listening",
      "image": "assets/images/listening.svg",
      "course": "2",
      "border": "#FFF48E",
      "color": "#FFD66B",
      "background": "#FFF9C2",
      "onTap": () {
        print("Listening");
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // color: Colors.amber,
      child: Container(
        padding: EdgeInsets.only(left: 30, right: 24),
        height: MediaQuery.of(context).size.height / 2,
        child: Flex(
          direction: Axis.horizontal,
          children: [
            MySeparator(width: 3, color: HexColor(mariner800)),
            Container(
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width / 20),
              width: MediaQuery.of(context).size.width / 1.19,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
                shrinkWrap: true,
                itemCount: learnings.length,
                itemBuilder: (context, index) {
                  final learning = learnings[index];
                  return (InkWell(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: learning["onTap"],
                    child: Container(
                      height: MediaQuery.of(context).size.height / 9,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: HexColor(learning["background"]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 2,
                              child:
                                  LayoutBuilder(builder: (context, constraint) {
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: constraint.maxHeight / 1,
                                      height: constraint.maxWidth / 1,
                                      decoration: BoxDecoration(
                                        color: HexColor(learning["color"]),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: HexColor(learning["border"]),
                                            width: 3),
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      learning['image'],
                                      width: constraint.maxHeight / 1.5,
                                    )
                                  ],
                                );
                              })),
                          Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    learning["title"],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width /
                                          3.8,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Center(
                                        child: Text(
                                          "${learning["course"]} Courses",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                              color: HexColor(mariner900)),
                                        ),
                                      ))
                                ],
                              )),
                        ],
                      ),
                    ),
                  ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.width = 1, this.color = Colors.black})
      : super(key: key);
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxHeight = constraints.constrainHeight();
        const dashHeight = 15.0;
        final dashWidth = width;
        final dashCount = (boxHeight / (2 * dashHeight)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(100)),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.vertical,
        );
      },
    );
  }
}

class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = size.width;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
