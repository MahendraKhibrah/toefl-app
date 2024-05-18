import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toefl/remote/api/bookmark_api.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_container.dart';

import '../../models/bookmark/bookmark.dart';
import '../../routes/route_key.dart';

class BookmarkedPage extends StatefulWidget {
  const BookmarkedPage({super.key});

  @override
  State<BookmarkedPage> createState() => _BookmarkedPageState();
}

class _BookmarkedPageState extends State<BookmarkedPage> {
  List<Bookmark> bookmarks = [];
  bool isLoading = false;
  BookmarkApi api = BookmarkApi();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    setState(() {
      isLoading = true;
    });

    bookmarks = await api.getAllBookmarks();

    setState(() {
      isLoading = false;
    });
  }

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
      body: Skeletonizer(
        enabled: isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                    "Let's review the questions you've\nbookmarked in the recent test!",
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.bold12
                        .copyWith(color: HexColor(neutral60))),
                const SizedBox(height: 16),
                ...(bookmarks.isNotEmpty
                    ? // Spacer between GenerateContainers
                    List.generate(
                        bookmarks.length,
                        (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: GenerateContainer(
                                text: bookmarks[index].question,
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    RouteKey.bookmarkDetail,
                                    arguments: bookmarks[index].id,
                                  );
                                },
                                onDelete: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await api.updateBookmark(bookmarks[index].id);
                                  _init();
                                },
                              ),
                            ))
                    : [
                        Center(
                          child: Text(
                            "You haven't bookmarked any questions yet",
                            style: CustomTextStyle.normal12,
                          ),
                        ),
                      ]),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GenerateContainer extends StatelessWidget {
  final String text;
  final Function() onTap;
  final Function() onDelete;

  const GenerateContainer({
    required this.text,
    required this.onTap,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeleton.leaf(
      child: GestureDetector(
        onTap: onTap,
        child: BlueContainer(
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
                GestureDetector(
                  onTap: onDelete,
                  child: SvgPicture.asset(
                    "assets/icons/ic_delete.svg",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
