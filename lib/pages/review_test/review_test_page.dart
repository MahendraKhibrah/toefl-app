import 'package:flutter/material.dart';
import 'package:toefl/models/test/answer.dart';
import 'package:toefl/pages/review_test/bottom_sheet_review_test.dart';
import 'package:toefl/pages/review_test/review_form_section.dart';
import 'package:toefl/remote/api/bookmark_api.dart';
import 'package:toefl/remote/api/full_test_api.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/common_app_bar.dart';

class ReviewTestPage extends StatefulWidget {
  const ReviewTestPage(
      {super.key, required this.packetId, required this.isFull});

  final String packetId;
  final bool isFull;

  @override
  State<ReviewTestPage> createState() => _ReviewTestPageState();
}

class _ReviewTestPageState extends State<ReviewTestPage> {
  final FullTestApi api = FullTestApi();
  final BookmarkApi bookmarkApi = BookmarkApi();
  var answers = <Answer>[];
  var isLoading = false;
  var selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    setState(() {
      isLoading = true;
    });
    answers = await api.getAnswers(widget.packetId);
    setState(() {
      selectedIndex = 0;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Positioned(
                    top: 50,
                    child: SizedBox(
                      width: screenWidth,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            SizedBox(
                              width: screenWidth,
                              child: Center(
                                child: Text(
                                  answers.first.packetName,
                                  style: CustomTextStyle.extraBold16
                                      .copyWith(fontSize: 20),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            selectedIndex < 0
                                ? const SizedBox()
                                : ReviewFormSection(
                                    answer: answers[selectedIndex],
                                    number: selectedIndex + 1,
                                  ),
                          ],
                        ),
                      ),
                    )),
                Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 4,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    width: screenWidth,
                    height: MediaQuery.of(context).size.height * 0.075,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                if (!(selectedIndex <= 0)) {
                                  setState(() {
                                    selectedIndex--;
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.chevron_left,
                                size: 30,
                              )),
                          const Spacer(),
                          _buildBookmark(),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return BottomSheetReviewTest(
                                        answers: answers,
                                        isFullTest: widget.isFull,
                                        onTap: (number) {},
                                      );
                                    }).then((value) {
                                  setState(() {
                                    selectedIndex = value - 1;
                                  });
                                });
                              },
                              icon: const Icon(
                                Icons.list,
                                size: 30,
                              )),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              if (!(selectedIndex >= answers.length - 1)) {
                                setState(() {
                                  selectedIndex++;
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.chevron_right,
                              size: 30,
                            ),
                          ),
                        ],
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

  IconButton _buildBookmark() {
    return IconButton(
      onPressed: () async {
        setState(() {
          isLoading = true;
        });
        final bookmarkStatus =
            await bookmarkApi.updateBookmark(answers[selectedIndex].id);
        setState(() {
          answers[selectedIndex] = Answer(
            id: answers[selectedIndex].id,
            bookmark: bookmarkStatus,
            question: answers[selectedIndex].question,
            keyQuestion: answers[selectedIndex].keyQuestion,
            typeQuestion: answers[selectedIndex].typeQuestion,
            isCorrect: answers[selectedIndex].isCorrect,
            userAnswer: answers[selectedIndex].userAnswer,
            nestedQuestionId: answers[selectedIndex].nestedQuestionId,
            nestedQuestion: answers[selectedIndex].nestedQuestion,
            choices: answers[selectedIndex].choices,
            packetName: answers[selectedIndex].packetName,
          );
          isLoading = false;
        });
      },
      icon: selectedIndex >= 0 && (answers[selectedIndex].bookmark)
          ? Icon(
              Icons.bookmark,
              color: HexColor(mariner700),
              size: 28,
            )
          : const Icon(
              Icons.bookmark_border,
              size: 28,
            ),
    );
  }
}
