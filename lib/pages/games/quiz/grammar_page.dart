import 'package:flutter/material.dart';
import 'package:toefl/models/quiz_game_answer.dart';
import 'package:toefl/models/quiz_question.dart';
import 'package:toefl/pages/full_test/toefl_audio_player.dart';
import 'package:toefl/pages/games/quiz/finish_quiz_page.dart';
import 'package:toefl/pages/games/quiz/splash_perfect.dart';
import 'package:toefl/remote/api/quiz_api.dart';
import 'package:toefl/remote/env.dart';
import 'package:toefl/state_management/quiz/quiz_provider_state.dart';
import 'package:toefl/widgets/answer_button.dart';
import 'package:toefl/widgets/answer_validation_container.dart';
import 'package:toefl/widgets/blue_button.dart';
import 'package:toefl/widgets/blue_container.dart';
import 'package:toefl/widgets/games/quiz/next_button.dart';

typedef void ListCallback(List<String> selectedIndex);

class GrammarPage extends StatefulWidget {
  final QuizQuestion question;
  final List<String> selectedIndex;
  final ListCallback? setButton;
  final List<QuizGameAnswer> quizGameAnswer;
  final QuizGame quizGame;
  const GrammarPage({
    super.key,
    required this.question,
    this.setButton,
    required this.quizGameAnswer,
    required this.quizGame,
    required this.selectedIndex,
  });

  @override
  State<GrammarPage> createState() => _GrammarPageState();
}

class _GrammarPageState extends State<GrammarPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Test _ ' + widget.selectedIndex.toString());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: widget.quizGame.quiz.type.name.toLowerCase() !=
                        'listening'
                    ? BlueContainer(
                        child: Text(widget.question.question),
                      )
                    : ToeflAudioPlayer(
                        url: '${Env.storageUrl}/${widget.question.question}'),
              ),
              ...List.generate(
                widget.question.content!.length,
                (indexCol) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10, top: 20, bottom: 10),
                      child: Text(
                        widget.question.content![indexCol].content,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    ...List.generate(
                      widget.question.content![indexCol].options!.length,
                      (indexList) => Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10),
                        child: AnswerButton(
                          isAnswerTrue: widget.selectedIndex[indexCol] != '' &&
                              widget.question.content![indexCol]
                                      .options![indexList].id ==
                                  widget.question.content![indexCol].answerKey
                                      .option.id,
                          isAnswerFalse: widget.selectedIndex[indexCol] ==
                                  widget.question.content![indexCol]
                                      .options![indexList].id &&
                              (widget.selectedIndex[indexCol] !=
                                  widget.question.content![indexCol].answerKey
                                      .option.id),
                          onTap: () {
                            if (widget.selectedIndex[indexCol] == '') {
                              setState(() {
                                widget.selectedIndex[indexCol] = widget.question
                                    .content![indexCol].options![indexList].id;
                              });
                              postAnswer(
                                  widget.selectedIndex[indexCol],
                                  widget.question.content![indexCol]
                                      .options![indexList].quizContentId,
                                  widget.quizGame.id,
                                  widget.quizGame.isGame);
                              widget.setButton!(widget.selectedIndex);
                            }
                          },
                          title:
                              '${String.fromCharCode(65 + indexList)}. ${widget.question.content![indexCol].options![indexList].options}',
                          // isActive: (widget.selectedIndex[indexCol] == -1 &&
                          //     widget.selectedIndex[indexCol] == indexList),
                          isActive: false,
                          isDisabled: widget.selectedIndex[indexCol] !=
                              widget.question.content![indexCol]
                                  .options![indexList].id,
                        ),
                      ),
                    ),
                    widget.selectedIndex[indexCol] != ''
                        ? AnswerValidationContainer(
                            isCorrect: widget.selectedIndex[indexCol] ==
                                widget.question.content![indexCol].answerKey
                                    .option.id,
                            keyAnswer:
                                '${widget.question.content![indexCol].answerKey.option.options}',
                            explanation: widget.question.content![indexCol]
                                .answerKey.explanation,
                          )
                        : Container(),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void postAnswer(
      String quizOptionId, String quizContentId, String claim, bool isGame) {
    QuizApi().postAnswer(quizOptionId, quizContentId, claim, isGame);
  }
}
