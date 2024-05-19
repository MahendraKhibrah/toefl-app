import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toefl/models/bookmark/bookmark_detail.dart';
import 'package:toefl/models/test/answer.dart';
import 'package:toefl/pages/review_test/review_form_section.dart';
import 'package:toefl/remote/api/bookmark_api.dart';
import 'package:toefl/utils/custom_text_style.dart';

class BookmarkDetailPage extends StatefulWidget {
  const BookmarkDetailPage({super.key, required this.bookmarkId});

  final String bookmarkId;

  @override
  State<BookmarkDetailPage> createState() => _FullTestPageState();
}

class _FullTestPageState extends State<BookmarkDetailPage> {
  BookmarkDetail bookmarkDetail = BookmarkDetail(
      id: "",
      question: "",
      keyQuestion: "",
      isCorrect: false,
      userAnswer: "",
      nestedQuestion: "",
      choices: []);
  bool isLoading = false;
  BookmarkApi api = BookmarkApi();

  @override
  void initState() {
    super.initState();
    _onInit();
  }

  void _onInit() async {
    setState(() {
      isLoading = true;
    });
    bookmarkDetail = await api.getBookmarkDetail(widget.bookmarkId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 50,
            child: SizedBox(
              width: screenWidth,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Skeletonizer(
                  enabled: isLoading,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          width: screenWidth,
                          child: Center(
                              child: Text(
                            "Bookmarked",
                            style: CustomTextStyle.extraBold16
                                .copyWith(fontSize: 20),
                          )),
                        ),
                        const SizedBox(height: 16),
                        ReviewFormSection(
                          heightMultiplier: 0.88,
                          answer: Answer(
                              id: bookmarkDetail.id,
                              question: bookmarkDetail.question,
                              keyQuestion: bookmarkDetail.keyQuestion,
                              typeQuestion: _getTypes(),
                              isCorrect: bookmarkDetail.isCorrect,
                              userAnswer: bookmarkDetail.userAnswer,
                              nestedQuestionId: "",
                              nestedQuestion: bookmarkDetail.nestedQuestion,
                              choices: bookmarkDetail.choices,
                              bookmark: true,
                              packetName: ""),
                          number: 1,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: 44,
              left: 18,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )),
        ],
      ),
    );
  }

  String _getTypes() {
    if (bookmarkDetail.nestedQuestion.isEmpty) {
      return "Structure";
    } else {
      if (bookmarkDetail.nestedQuestion.contains("mp3")) {
        return "Listening";
      } else {
        return "Reading";
      }
    }
  }
}
