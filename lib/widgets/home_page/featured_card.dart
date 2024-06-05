import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class FeaturedCard extends StatelessWidget {
  const FeaturedCard({
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
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: isBgLight ? HexColor(mariner100) : HexColor(mariner400),
        ),
        width: MediaQuery.of(context).size.width / 2.43,
        height: MediaQuery.of(context).size.height / 7,
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(icon,
                  color:
                      isBgLight ? HexColor(mariner900) : HexColor(neutral10)),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color:
                        isBgLight ? HexColor(mariner900) : HexColor(neutral10)),
              ),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color:
                        isBgLight ? HexColor(mariner900) : HexColor(neutral10)),
              ),
            ],
          ),
        ),
      );
    });
  }
}
