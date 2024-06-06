import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toefl/pages/games/practice/pairing_game.dart';
import 'package:toefl/remote/api/mini_game_api.dart';
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

class WordScramblePage extends StatefulWidget {
  const WordScramblePage({super.key});

  @override
  _WordScramblePageState createState() => _WordScramblePageState();
}

class _WordScramblePageState extends State<WordScramblePage> {
  late Future<Map<String, dynamic>> wordDataFuture;
  late List<String> _word = [];
  late List<String> _scrambledWord = [];
  late List<String> _selectedWord = [];
  late String textSoal = '';
  late bool _isCorrect = false;
  late String wordId = '';
  bool _isCheck = false;

  @override
  void initState() {
    super.initState();
    wordDataFuture = getData();
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
    String word = wordData['Word']!;
    _word = word.toUpperCase().split('');
    _scrambledWord = _word.toList();
    // print(wordData['_id']);
    print(_word);
    final int additionalChars = _word.length ~/ 2;
    for (int i = 0; i < additionalChars; i++) {
      _scrambledWord
          .add((String.fromCharCode(random.nextInt(26) + 65).toUpperCase()));
    }
    wordId = wordData['_id']['\$oid']!;
    String rawSoal = wordData['Examples/0']!;
    print(word);
    print(rawSoal.split(word));
    List<String> splitSoal = GameUtils().splitStringWithoutCaps(rawSoal, word);
    textSoal = GameUtils().joinSubstrings(splitSoal, word.length);
    _scrambledWord.shuffle(random);
    _selectedWord = [];
    _isCorrect = false;
    // setState(() {});
  }

  void _onLetterSelected(int index) {
    if (!_isCheck) {
      setState(() {
        final String letter = _scrambledWord.removeAt(index);
        _selectedWord.add(letter);
      });
    }
  }

  void _onSelectedLetterDeselected(int index) {
    if (!_isCheck) {
      setState(() {
        final String letter = _selectedWord.removeAt(index);
        _scrambledWord.add(letter);
        _scrambledWord.shuffle();
      });
    }
  }

  void _checkAnswer() {
    setState(() {
      _isCorrect = ListEquality().equals(_selectedWord, _word);
      _isCheck = true;
    });
  }

  void _nextWord() async {
    if (_isCheck) {
      final isSaved =
          await MiniGameApi().storeScrambledWord(wordId, _isCorrect);
      if (isSaved) {
        setState(() {
          _word = [];
          wordDataFuture = getData();
          _isCheck = false;
        });
      }
    } else if (!_isCheck) {
      if (_word.isNotEmpty) {
        _checkAnswer();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GameAppBar(
        title: 'Scrambled Word',
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: FutureBuilder(
                    future: wordDataFuture,
                    builder: (context,
                        AsyncSnapshot<Map<String, dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        if (_word.isEmpty) {
                          _initializeGame(snapshot.data!);
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            BlueContainer(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  textSoal,
                                  style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor(mariner900)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Center(
                                child: Text(
                                  'Fill the blanks using suitable words!',
                                  style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children:
                                    _selectedWord.asMap().entries.map((entry) {
                                  final int index = entry.key;
                                  final String letter = entry.value;
                                  return GestureDetector(
                                    onTap: () =>
                                        _onSelectedLetterDeselected(index),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        letter,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Divider(
                              height: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children:
                                    _scrambledWord.asMap().entries.map((entry) {
                                  final int index = entry.key;
                                  final String letter = entry.value;
                                  return GestureDetector(
                                    onTap: () => _onLetterSelected(index),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        letter,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
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
                        keyAnswer: _word.join(),
                        explanation: '',
                      )
                    : AnswerValidationContainer(
                        isCorrect: false,
                        keyAnswer: _word.join(),
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
