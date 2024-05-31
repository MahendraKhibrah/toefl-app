import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class TryCard extends StatelessWidget {
  const TryCard({
    super.key,
    this.child,
    this.icon = "",
    this.title = "title",
    this.subtitle = "subtitle",
    this.isBgLight = true,
  });

  final Widget? child;
  final String icon;
  final String title;
  final String subtitle;
  final bool isBgLight;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      child: LayoutBuilder(
        builder: (context, constraint) {
          return Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color:
                        isBgLight ? HexColor(mariner100) : HexColor(mariner400),
                  ),
                  width: MediaQuery.of(context).size.width / 2.43,
                  height: MediaQuery.of(context).size.height / 5,
                  child: Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 15, vertical: 15),
                  )),
              Positioned(
                  top: (constraint.maxHeight / 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.4,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              title,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: isBgLight
                                      ? HexColor(mariner900)
                                      : HexColor(neutral10)),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            SvgPicture.asset(icon,
                                color: isBgLight
                                    ? HexColor(mariner900)
                                    : HexColor(neutral10))
                          ],
                        ),
                        Text(
                          subtitle,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: isBgLight
                                  ? HexColor(mariner900)
                                  : HexColor(neutral10)),
                        ),
                      ],
                    ),
                  )),
              if (child != null) child!,
            ],
          );
        },
      ),
    );
  }
}
