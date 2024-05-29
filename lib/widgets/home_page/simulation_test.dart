import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';
import 'package:toefl/routes/navigator_key.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class SimulationTestWidget extends StatelessWidget {
  SimulationTestWidget({super.key});

  List<Map<String, dynamic>> topics = [
    {
      "title": "Mini Test",
      "subtitle": "70 questions",
      "color": mariner100,
      "icon": "assets/images/pesawat.svg",
      "onTap": () {
        final context = navigatorKey.currentState?.overlay?.context;

        if (context != null && context.mounted) {
          Navigator.of(context).pushNamed(RouteKey.miniSimulationTest);
        }
      }
    },
    {
      "title": "Full Test",
      "subtitle": "140 questions",
      "color": mariner400,
      "icon": "assets/images/medali.svg",
      "onTap": () {
        final context = navigatorKey.currentState?.overlay?.context;

        if (context != null && context.mounted) {
          Navigator.of(context).pushNamed(RouteKey.simulationpage);
        }
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      width: double.infinity,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 24),
        separatorBuilder: (context, index) => const SizedBox(
          width: 15,
        ),
        shrinkWrap: true,
        itemCount: topics.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final topic = topics[index];
          return LayoutBuilder(
            builder: (context, constraint) {
              return Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: HexColor(topic["color"]),
                      ),
                      width: MediaQuery.of(context).size.width / 2.43,
                      height: MediaQuery.of(context).size.height / 5,
                      child: Padding(
                        padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 15, vertical: 15),
                      )),
                  Positioned(
                    top: (constraint.maxHeight / 10),
                    left: (constraint.maxHeight / 15),
                    child: Text(
                      topic["title"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: (constraint.maxHeight / 10),
                          fontWeight: FontWeight.w800,
                          color: (index == 0)
                              ? HexColor(mariner900)
                              : HexColor(neutral10)),
                    ),
                  ),
                  Positioned(
                      top: (constraint.maxHeight / 10),
                      right: (index == 0)
                          ? (constraint.maxHeight / 3.5)
                          : (constraint.maxHeight / 2.8),
                      child: SvgPicture.asset(
                        topic["icon"],
                        color: (index == 0)
                            ? HexColor("#76B7E4")
                            : HexColor(mariner100),
                        height: constraint.maxHeight / 8,
                      )),
                  Positioned(
                    top: (constraint.maxHeight / 4),
                    left: (constraint.maxHeight / 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "A test that contains ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: constraint.maxHeight / 16,
                              fontWeight: FontWeight.w800,
                              color: (index == 0)
                                  ? HexColor(mariner900)
                                  : HexColor(neutral10)),
                        ),
                        Text(
                          topic["subtitle"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: constraint.maxHeight / 16,
                              fontWeight: FontWeight.w800,
                              color: (index == 0)
                                  ? HexColor(mariner900)
                                  : HexColor(neutral10)),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      right: -(constraint.maxHeight / 70),
                      top: (constraint.maxHeight / 16),
                      child: SvgPicture.asset(
                        "assets/images/vector_bg_st.svg",
                        color: (index == 0)
                            ? HexColor("#76B7E4")
                            : HexColor(mariner100),
                        width: constraint.maxHeight / 1,
                      )),
                  Positioned(
                      bottom: constraint.maxHeight / 12,
                      right: (constraint.maxHeight / 18),
                      child: SizedBox(
                        height: constraint.maxHeight / 5,
                        width: constraint.maxHeight / 1.8,
                        child: TextButton(
                            onPressed: topic["onTap"],
                            child: Text(
                              "Try",
                              style: TextStyle(
                                  fontSize: constraint.maxHeight / 14,
                                  fontWeight: FontWeight.w800,
                                  color: HexColor(mariner900)),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  HexColor(topic["color"])),
                            )),
                      ))
                ],
              );
            },
          );
        },
      ),
    );
  }
}
