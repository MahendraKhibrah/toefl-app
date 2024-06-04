import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toefl/pages/games/practice/pairing_game.dart';
import 'package:toefl/pages/games/practice/testing.dart';
import 'package:toefl/remote/api/scrambled_word_api.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/game_utils.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/answer_validation_container.dart';
import 'package:toefl/widgets/blue_button.dart';
import 'package:collection/collection.dart';
import 'package:toefl/widgets/blue_container.dart';
import 'package:toefl/widgets/quiz/modal/modal_confirmation.dart';

import '../../../widgets/games/game_app_bar.dart';

class SentenceScramblePage extends StatefulWidget {
  const SentenceScramblePage({super.key});

  @override
  _SentenceScramblePageState createState() => _SentenceScramblePageState();
}

class _SentenceScramblePageState extends State<SentenceScramblePage> {
  late Future<Map<String, dynamic>> sentenceDataFuture;
  late List<String> _sentences = [];
  late List<String> _scrambledSentence = [];
  late List<String> _selectedWord = [];
  late String textSoal = '';
  late bool _isCorrect = false;
  late String wordId = '';
  bool _isCheck = false;

  @override
  void initState() {
    super.initState();
    sentenceDataFuture = getData();
  }

  Future<Map<String, dynamic>> getData() async {
    Random random = Random();
    final String response =
        await rootBundle.loadString('assets/json/word.json');
    final List<dynamic> data = json.decode(response);
    final Map<String, dynamic> dataWord =
        Map<String, dynamic>.from(data[random.nextInt(data.length)]);
    return dataWord;
  }

  void _initializeGame(Map<String, dynamic> wordData) {
    final Random random = Random();
    String word = wordData['Meaning']!;
    String pengecoh = wordData['Examples/1'];
    textSoal = word;

    _sentences = word.split(' ');
    _scrambledSentence = _sentences.toList();
    print(_sentences);

    _scrambledSentence.add(pengecoh.split(' ').first);
    _scrambledSentence.add(pengecoh.split(' ').last);
    _scrambledSentence.add(pengecoh.split(' ')[1]);

    wordId = wordData['_id']['\$oid']!;
    _scrambledSentence.shuffle(random);
    _selectedWord = [];
    _isCorrect = false;
  }

  void _onLetterSelected(int index) {
    if (!_isCheck) {
      setState(() {
        final String letter = _scrambledSentence.removeAt(index);
        _selectedWord.add(letter);
      });
    }
  }

  void _onSelectedLetterDeselected(int index) {
    if (!_isCheck) {
      setState(() {
        final String letter = _selectedWord.removeAt(index);
        _scrambledSentence.add(letter);
      });
    }
  }

  void _checkAnswer() {
    setState(() {
      _isCorrect = ListEquality().equals(_selectedWord, _sentences);
      _isCheck = true;
    });
  }

  void _nextWord() async {
    if (_isCheck) {
      final isSaved = true;
      // await ScrambledWordApi().storeScrambled(wordId, _isCorrect);
      if (isSaved) {
        setState(() {
          _sentences = [];
          sentenceDataFuture = getData();
          _isCheck = false;
        });
      }
    } else if (!_isCheck) {
      if (_sentences.isNotEmpty) {
        _checkAnswer();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GameAppBar(
        title: 'Listening',
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: FutureBuilder(
                    future: sentenceDataFuture,
                    builder: (context,
                        AsyncSnapshot<Map<String, dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        if (_sentences.isEmpty) {
                          _initializeGame(snapshot.data!);
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/maskot_2.svg',
                                  height:
                                      MediaQuery.of(context).size.width * 0.4,
                                ),
                                SoalToAudioWidget(
                                  text: textSoal,
                                  child: SvgPicture.asset(
                                    'assets/images/game_scrambled_audio.svg',
                                    height: MediaQuery.of(context).size.width *
                                        0.25,
                                  ),
                                  rate: 0.45,
                                ),
                              ],  
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: SizedBox(
                                height: _selectedWord.isNotEmpty ? null : 50,
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: _selectedWord
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    final int index = entry.key;
                                    final String letter = entry.value;
                                    return TextButton(
                                      onPressed: () =>
                                          _onSelectedLetterDeselected(index),
                                      style: TextButton.styleFrom(
                                        backgroundColor: HexColor(colorSuccess),
                                        minimumSize: Size(50, 50),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        letter,
                                        style: GoogleFonts.nunito(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 10,
                                runSpacing: 10,
                                children: _scrambledSentence
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final int index = entry.key;
                                  final String letter = entry.value;
                                  return TextButton(
                                    onPressed: () => _onLetterSelected(index),
                                    style: TextButton.styleFrom(
                                      backgroundColor: HexColor(mariner500),
                                      minimumSize: Size(50, 50),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      letter,
                                      style: GoogleFonts.nunito(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, top: 4),
            child: _isCheck
                ? _isCorrect
                    ? AnswerValidationContainer(
                        isCorrect: true,
                        keyAnswer: _sentences.join(' '),
                        explanation: '',
                      )
                    : AnswerValidationContainer(
                        isCorrect: false,
                        keyAnswer: _sentences.join(' '),
                        explanation: '',
                      )
                : Text(''),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: BlueButton(
              title: _isCheck ? 'Next Word' : 'Check',
              onTap: _nextWord,
            ),
          ),
        ],
      ),
    );
  }
}
