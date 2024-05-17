import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_container.dart';

class BookmarkedPage extends StatefulWidget {
  const BookmarkedPage({Key? key}) : super(key: key);

  @override
  State<BookmarkedPage> createState() => _BookmarkedPageState();
}

class _BookmarkedPageState extends State<BookmarkedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Bookmarked",
          style: CustomTextStyle.extraBold16,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
                "Let's review the questions you've\nbookmarked in the recent test!",
                textAlign: TextAlign.center,
                style: CustomTextStyle.bold12
                    .copyWith(color: HexColor(neutral60))),
            SizedBox(height: 16), // Spacer between GenerateContainers
            GenerateContainer(
              text:
                  "Following Ms. Rivera’s ... statement.\nthe official awards ceremony for Plex\nIndustries will commence. ",
            ),
            SizedBox(height: 8), // Spacer between GenerateContainers
            GenerateContainer(
              text:
                  "Despite having some problems with\nthe sound system during the\nperformance, the concert was an ...\nexperience for everyone.",
            ),
          ],
        ),
      ),
    );
  }
}

class GenerateContainer extends StatelessWidget {
  final String text;

  const GenerateContainer({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlueContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(
                width: 200,
                child: Text(
                  text,
                  style: CustomTextStyle.normal12,
                ),
              ),
            ),
            SvgPicture.asset(
              "assets/icons/ic_delete.svg",
            ),
          ],
        ),
      ),
    );
  }
}
