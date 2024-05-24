import 'package:flutter/material.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_container.dart';
import 'package:flutter/widgets.dart';

class LearningPathPage extends StatelessWidget {
  final String appBar;
  LearningPathPage({super.key, required this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          centerTitle: true,
          leading: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(
              Icons.chevron_left_rounded,
              size: 30,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Text(appBar),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Text(
                "Select Lesson to Practice",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: HexColor(neutral60)),
              ),
            ),
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: 5, // Jumlah item dalam ListView
              itemBuilder: (context, index) {
                return Container(
                    height: MediaQuery.of(context).size.height / 8,
                    margin: EdgeInsets.only(left: 24, bottom: 20.0),
                    child: Row(
                      children: [
                        MySeparator(width: 3, color: HexColor(mariner800)),
                        Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(left: 16, right: 24),
                                child: LayoutBuilder(
                                  builder: (context, constraint) {
                                    return BlueContainer(
                                        child: Container(
                                      height: constraint.maxHeight / 1,
                                      child: Flex(
                                        direction: Axis.horizontal,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Lorem",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: HexColor("#2F2F2F")),
                                              ),
                                              Text("easy",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          HexColor(neutral60)))
                                            ],
                                          )
                                        ],
                                      ),
                                    ));
                                  },
                                )))
                      ],
                    ));
              },
            ),
          ],
        ));
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
