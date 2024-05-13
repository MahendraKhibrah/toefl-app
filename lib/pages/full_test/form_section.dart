import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toefl/models/packet_detail.dart';
import 'package:toefl/pages/full_test/multiple_choices.dart';
import 'package:toefl/pages/full_test/toefl_audio_player.dart';
import 'package:toefl/remote/env.dart';
import 'package:toefl/widgets/answer_button.dart';
import 'package:toefl/widgets/blue_container.dart';

import '../../state_management/full_test_provider.dart';
import '../../utils/colors.dart';
import '../../utils/custom_text_style.dart';
import '../../utils/hex_color.dart';
import 'bottom_sheet_transcript.dart';

class FormSection extends ConsumerStatefulWidget {
  const FormSection({super.key, required this.questions});

  final List<Question> questions;

  @override
  ConsumerState<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends ConsumerState<FormSection> {
  List<Question> questions = [
    Question(
      id: "",
      question: "",
      typeQuestion: "",
      nestedQuestionId: "",
      choices: [],
      bigQuestion: "",
      answer: "",
      bookmarked: 0,
      number: 0,
    )
  ];

  @override
  void initState() {
    if (widget.questions.isNotEmpty) {
      questions = widget.questions;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        SizedBox(
          width: screenWidth * 0.92,
          height: screenHeight * 0.7,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                questions.first.typeQuestion == "Reading"
                    ? Skeleton.leaf(
                        child: BlueContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HtmlWidget(
                                questions.first.bigQuestion,
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
                questions.first.typeQuestion == "Listening" &&
                        (questions.first.bigQuestion).contains("mp3")
                    ? Skeleton.leaf(
                        child: ToeflAudioPlayer(
                        url: '${Env.storageUrl}/${questions.first.bigQuestion}',
                      ))
                    : const SizedBox(),
                const SizedBox(
                  height: 20,
                ),
                ...List.generate(questions.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildQuestion(questions[index]),
                    ),
                  );
                }),
                const SizedBox(
                  height: 80,
                )
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 20,
            right: 0,
            child: (questions.first.typeQuestion) == "Reading"
                ? _buildFloatingButton(context)
                : const SizedBox())
      ],
    );
  }

  List<Widget> _buildQuestion(Question question) {
    return [
      Padding(
        padding: EdgeInsets.only(bottom: question.question.isEmpty ? 8.0 : 0),
        child: Text(
          "Question ${question.number}",
          style: CustomTextStyle.bold16.copyWith(fontSize: 14),
        ),
      ),
      question.question.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 12),
              child: Text(
                question.question,
                style: CustomTextStyle.medium14,
              ),
            )
          : const SizedBox(),
      Consumer(builder: (context, ref, child) {
        final state = ref.watch(fullTestProvider);
        if (state.selectedQuestions.isEmpty) {
          return Column(
            children: List.generate(4, (index) {
              return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Skeleton.replace(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: AnswerButton(
                        onTap: () {},
                        title: "(${String.fromCharCode(65 + index)}) $index",
                        isActive: false),
                  ));
            }),
          );
        } else {
          return MultipleChoices(question: question);
        }
      }),
    ];
  }

  Widget _buildFloatingButton(BuildContext context) {
    return Skeleton.leaf(
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return BottomSheetTranscript(
                  htmlText: questions.first.bigQuestion,
                );
              });
        },
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              color: HexColor(mariner500),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(1, 3),
                ),
              ]),
          child: Column(
            children: [
              const SizedBox(
                height: 6,
              ),
              Text(
                "See\nTranscript",
                textAlign: TextAlign.center,
                style: CustomTextStyle.bold16.copyWith(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              const Icon(
                Icons.menu_book_outlined,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
