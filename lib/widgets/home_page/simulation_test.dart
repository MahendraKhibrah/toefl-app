import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class SimulationTest extends StatelessWidget {
  SimulationTest({super.key});
  List<Map<String, dynamic>> topics = [
    {
      "title": "Mini Test",
      "subtitle": "A test that contains 70 questions",
      "color": mariner100,
      "onTap": () {
        print("Mini Tes");
      }
    },
    {
      "title": "Full Test",
      "subtitle": "A test that contains 140 questions",
      "color": mariner200,
      "onTap": () {
        print("Full tes");
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
          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: HexColor(topic["color"]),
              ),
              margin: EdgeInsets.only(left: 0),
              width: MediaQuery.of(context).size.width / 2.43,
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            topic["title"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: HexColor("#20304B")),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            topic["subtitle"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: HexColor(mariner700)),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            onPressed: topic["onTap"],
                            child: Text(
                              "Try",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: HexColor(mariner900)),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            )),
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
