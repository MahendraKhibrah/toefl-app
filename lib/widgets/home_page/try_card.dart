import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class TryCard extends StatelessWidget {
  const TryCard(
      {super.key,
      this.child,
      this.title = "title",
      this.subtitle = "subtitle",
      this.isBgLight = true,
      this.onPressed});

  final Widget? child;
  final String title;
  final String subtitle;
  final bool isBgLight;
  final Function(BuildContext)? onPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
              left: (constraint.maxHeight / 15),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: (constraint.maxHeight / 10),
                    fontWeight: FontWeight.w800,
                    color:
                        isBgLight ? HexColor(mariner900) : HexColor(neutral10)),
              ),
            ),
            // Positioned(
            //     top: (constraint.maxHeight / 10),
            //     right: (index == 0)
            //         ? (constraint.maxHeight / 3.5)
            //         : (constraint.maxHeight / 2.8),
            //     child: SvgPicture.asset(
            //       topic["icon"],
            //       color:
            //           (index == 0) ? HexColor("#76B7E4") : HexColor(mariner100),
            //       height: constraint.maxHeight / 8,
            //     )),
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
                        color: isBgLight
                            ? HexColor(mariner900)
                            : HexColor(neutral10)),
                  ),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: constraint.maxHeight / 16,
                        fontWeight: FontWeight.w800,
                        color: isBgLight
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
                  color: isBgLight ? HexColor("#76B7E4") : HexColor(mariner100),
                  width: constraint.maxHeight / 1,
                )),
            Positioned(
                bottom: constraint.maxHeight / 12,
                right: (constraint.maxHeight / 18),
                child: SizedBox(
                  height: constraint.maxHeight / 5,
                  width: constraint.maxHeight / 1.8,
                  child: TextButton(
                      onPressed: () {
                        if (onPressed != null) {
                          onPressed!(context);
                        }
                      },
                      child: Text(
                        "Try",
                        style: TextStyle(
                            fontSize: constraint.maxHeight / 14,
                            fontWeight: FontWeight.w800,
                            color: HexColor(mariner900)),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            isBgLight
                                ? HexColor(mariner100)
                                : HexColor(mariner400)),
                      )),
                ))
          ],
        );
      },
    );
  }
}
