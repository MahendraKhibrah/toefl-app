import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:toefl/models/games/game_tense.dart';
import 'package:toefl/models/word_synonym.dart';
import 'package:toefl/remote/api/pairing_api.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/answer_validation_container.dart';
import 'package:toefl/widgets/blue_button.dart';
import 'package:toefl/widgets/quiz/modal/modal_confirmation.dart';
import 'package:string_similarity/string_similarity.dart';

import '../../../widgets/games/game_app_bar.dart';

class SpeakingGame extends StatefulWidget {
  const SpeakingGame({super.key});

  @override
  State<SpeakingGame> createState() => _SpeakingGameState();
}

class _SpeakingGameState extends State<SpeakingGame> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _userAnswer = '';
  String _answerKey = '';
  bool _isCheck = false;
  bool _isCorrect = false;
  bool _disable = true;
  double accuracy = 0;

  @override
  void initState() {
    super.initState();
    _loadWords();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _userAnswer = result.recognizedWords;
      if (result.recognizedWords != '') {
        _disable = false;
      }
    });
  }

  void _loadWords() async {
    _userAnswer = '';
    _answerKey = '';

    String jsonData = await rootBundle.loadString('assets/json/tenses.json');
    final List<dynamic> parsedJson = jsonDecode(jsonData);
    List<GameTense> sentence =
        parsedJson.map((json) => GameTense.fromJson(json)).toList();
    sentence.shuffle();
    setState(() {
      _answerKey = sentence.take(1).toList().first.sentence!;
    });
  }

  void _checkAnswer() {
    var simillar = _answerKey
        .replaceAll("\\.", "")
        .replaceAll("\\,", "")
        .toLowerCase()
        .similarityTo(_userAnswer);
    setState(() {
      // _isCorrect =
      accuracy = simillar;
      _isCorrect = true;
      _isCheck = true;
    });
  }

  void _nextWord() async {
    print('test');
    if (_isCheck) {
      final isSaved = true;
      // await ScrambledWordApi().storeScrambled(wordId, _isCorrect);
      if (isSaved) {
        setState(() {
          _userAnswer = '';
          _answerKey = '';
          _isCheck = false;
          _disable = true;
        });
        _loadWords();
      }
    } else if (!_isCheck) {
      if (_userAnswer != '') {
        _checkAnswer();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GameAppBar(
        title: 'Speaking',
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/maskot_1.svg',
                      height: MediaQuery.of(context).size.width * 0.4,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/game_speaking_board.svg',
                            height: MediaQuery.of(context).size.width * 0.28,
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      _answerKey,
                                      style: GoogleFonts.nunito(
                                        fontSize: 18,
                                        color: HexColor(mariner900),
                                        fontWeight: FontWeight.w900,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.all(24),
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Text(
                      _userAnswer,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: _isCheck
                      ? AnswerValidationContainer(
                          isCorrect: true,
                          keyAnswer: '',
                          explanation:
                              '${(accuracy * 10).toStringAsFixed(1)} / 10',
                        )
                      : Text(''),
                ),
                TextButton(
                  onPressed: _speechToText.isNotListening
                      ? _startListening
                      : _stopListening,
                  style: _speechToText.isNotListening
                      ? TextButton.styleFrom(
                          backgroundColor: HexColor(neutral10),
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 60),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 3, color: HexColor(mariner700)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      : TextButton.styleFrom(
                          backgroundColor: HexColor(mariner700),
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 60),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                  child: SvgPicture.asset(
                    _speechToText.isNotListening
                        ? 'assets/images/vector_game_mic_off.svg'
                        : 'assets/images/vector_game_mic_on.svg',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: BlueButton(
                    isDisabled: _disable,
                    title: _isCheck ? 'Next Word' : 'Check',
                    onTap: _nextWord,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // void showModalEnd() async {
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (context) {
  //       return ModalConfirmation(
  //         message: "Score",
  //         leftTitle: "Quit",
  //         rightTitle: "Retry",
  //         rightFunction: () {
  //           _loadWords();
  //           Navigator.pop(context);
  //         },
  //         leftFunction: () => Navigator.pushNamedAndRemoveUntil(
  //           context,
  //           RouteKey.main,
  //           (route) => false,
  //         ),
  //       );
  //     },
  //   );
  // }
}
