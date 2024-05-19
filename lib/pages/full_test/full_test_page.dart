import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:toefl/pages/full_test/close_app_dialog.dart';
import 'package:toefl/pages/full_test/form_section.dart';
import 'package:toefl/pages/full_test/submit_dialog.dart';
import 'package:toefl/state_management/full_test_provider.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';

import 'bookmark_button.dart';
import 'bottom_sheet_full_test.dart';

class FullTestPage extends ConsumerWidget {
  const FullTestPage(
      {super.key, required this.diffInSec, required this.isRetake});

  final int diffInSec;
  final bool isRetake;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final FullTestProviderState state = ref.watch(fullTestProvider);

    return PopScope(
      canPop: false,
      onPopInvoked: (val) async {
        _showFinishedDialog(context, ref);
      },
      child: Scaffold(
        body: Stack(
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
                            child: Consumer(
                              builder: (context, ref, child) {
                                final state = ref.watch(fullTestProvider);
                                return Text(
                                  state.packetDetail.name,
                                  style: CustomTextStyle.extraBold16
                                      .copyWith(fontSize: 20),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            GestureDetector(
                              onTap: () async {
                                _showFinishedDialog(context, ref);
                              },
                              child: Text(
                                "Submit",
                                style: CustomTextStyle.extraBold16
                                    .copyWith(color: HexColor(mariner700)),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "${ref.watch(fullTestProvider).questionsFilledStatus.where((element) => element == true).length}/140",
                              style: CustomTextStyle.bold16.copyWith(
                                color: HexColor(mariner700),
                                fontSize: 14,
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: screenWidth * 0.5,
                              child: LinearProgressIndicator(
                                value: ref
                                        .watch(fullTestProvider)
                                        .questionsFilledStatus
                                        .where((element) => element == true)
                                        .length /
                                    140,
                                backgroundColor: HexColor(neutral40),
                                color: HexColor(mariner700),
                                minHeight: 7,
                                borderRadius: BorderRadius.circular(9),
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.timer,
                              color: HexColor(colorSuccess),
                              size: 18,
                            ),
                            SlideCountdown(
                              duration: diffInSec >=
                                      const Duration(hours: 2).inSeconds
                                  ? const Duration(seconds: 2)
                                  : const Duration(hours: 2) -
                                      Duration(seconds: diffInSec),
                              style: CustomTextStyle.bold16.copyWith(
                                color: HexColor(colorSuccess),
                                fontSize: 14,
                              ),
                              separator: ":",
                              separatorStyle: CustomTextStyle.bold16.copyWith(
                                color: HexColor(colorSuccess),
                                fontSize: 14,
                              ),
                              padding: const EdgeInsets.only(left: 8),
                              separatorPadding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              onDone: () async {
                                ref
                                    .read(fullTestProvider.notifier)
                                    .submitAnswer()
                                    .then((value) {
                                  if (value) {
                                    ref
                                        .read(fullTestProvider.notifier)
                                        .resetAll()
                                        .then((value) {
                                      Navigator.pop(context);
                                    });
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final state = ref.watch(fullTestProvider);
                            if (state.isSubmitLoading) {
                              return Column(children: [
                                Lottie.network(
                                    "https://lottie.host/61d1d16f-3171-4938-8112-e22de35c9943/5CS2iho5Gd.json",
                                    width: 400,
                                    height: 400),
                                Transform.translate(
                                    offset: const Offset(0, -50),
                                    child: Text("Sending data..",
                                        style: CustomTextStyle.bold16
                                            .copyWith(fontSize: 26))),
                              ]);
                            } else if (state.isLoading) {
                              return const Skeletonizer(
                                child: FormSection(
                                  questions: [],
                                ),
                              );
                            } else if (state.selectedQuestions.isNotEmpty) {
                              return FormSection(
                                questions: state.selectedQuestions,
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
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
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            if ((state.selectedQuestions.firstOrNull?.number ??
                                    1) <=
                                1) {
                              return;
                            } else {
                              ref
                                  .read(fullTestProvider.notifier)
                                  .getQuestionByNumber((state.selectedQuestions
                                              .firstOrNull?.number ??
                                          1) -
                                      1);
                            }
                          },
                          icon: const Icon(
                            Icons.chevron_left,
                            size: 50,
                          )),
                      const Spacer(),
                      Consumer(
                        builder: (context, ref, child) {
                          final state = ref.watch(fullTestProvider);
                          if (state.selectedQuestions.firstOrNull?.bookmarked ==
                              null) {
                            return IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.bookmark_border,
                                  size: 35,
                                ));
                          } else {
                            return BookmarkButton(
                              initalValue: state.selectedQuestions.firstOrNull
                                      ?.bookmarked ??
                                  1,
                              questions: state.selectedQuestions,
                            );
                          }
                        },
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            ref
                                .read(fullTestProvider.notifier)
                                .getQuestionsFilledStatus()
                                .then((value) {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return BottomSheetFullTest(
                                      filledStatus: value,
                                      onTap: (number) {},
                                    );
                                  }).then((value) {
                                ref
                                    .read(fullTestProvider.notifier)
                                    .getQuestionByNumber(value);
                              });
                            });
                          },
                          icon: const Icon(
                            Icons.list,
                            size: 50,
                          )),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          if ((state.selectedQuestions.lastOrNull?.number ??
                                  140) >=
                              140) {
                            return;
                          } else {
                            ref
                                .read(fullTestProvider.notifier)
                                .getQuestionByNumber((state.selectedQuestions
                                            .lastOrNull?.number ??
                                        140) +
                                    1);
                          }
                        },
                        icon: const Icon(
                          Icons.chevron_right,
                          size: 50,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showFinishedDialog(BuildContext context, WidgetRef ref) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext submitContext) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          content: SubmitDialog(
              onNo: () {
                Navigator.pop(submitContext);
              },
              onYes: () async {
                Navigator.pop(submitContext);
                bool submitResult = false;
                if (isRetake) {
                  submitResult = await ref
                      .read(fullTestProvider.notifier)
                      .resubmitAnswer();
                } else {
                  submitResult =
                      await ref.read(fullTestProvider.notifier).submitAnswer();
                }
                if (submitResult) {
                  bool resetResult =
                      await ref.read(fullTestProvider.notifier).resetAll();
                  if (resetResult && context.mounted) {
                    Navigator.pop(context);
                  }
                }
              },
              unAnsweredQuestion: ref
                  .watch(fullTestProvider)
                  .questionsFilledStatus
                  .where((element) => element == false)
                  .length),
        );
      },
    );
  }
}
