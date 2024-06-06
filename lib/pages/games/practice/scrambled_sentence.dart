import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toefl/models/games/game_tense.dart';
import 'package:toefl/remote/api/mini_game_api.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/answer_validation_container.dart';
import 'package:toefl/widgets/blue_button.dart';
import 'package:collection/collection.dart';

import '../../../widgets/games/game_app_bar.dart';
import '../../../widgets/games/soal_to_audio_widget.dart';

class SentenceScramblePage extends StatefulWidget {
  const SentenceScramblePage({super.key});

  @override
  _SentenceScramblePageState createState() => _SentenceScramblePageState();
}

class _SentenceScramblePageState extends State<SentenceScramblePage> {
  late Future<List<GameTense>> sentenceDataFuture;
  late List<String> _sentences = [];
  late List<String> _scrambledSentence = [];
  late List<String> _selectedWord = [];
  late String textSoal = '';
  late bool _isCorrect = false;
  late String tenseId = '';
  bool _isCheck = false;

  @override
  void initState() {
    super.initState();
    sentenceDataFuture = getData();
  }

  Future<List<GameTense>> getData() async {
    Random random = Random();
    final String response =
        await rootBundle.loadString('assets/json/tenses.json');
    final List<dynamic> data = json.decode(response);
    List<GameTense> tense =
        data.map((json) => GameTense.fromJson(json)).toList();
    return [tense[random.nextInt(2200)], tense[random.nextInt(2200)]];
  }

  void _initializeGame(List<GameTense> tenses) {
    final Random random = Random();
    String word = tenses.first.sentence!;
    String pengecoh = tenses.last.sentence!;
    textSoal = word;

    _sentences = word.split(' ');
    _scrambledSentence = _sentences.toList();
    print(_sentences);
    if (pengecoh != '') {
      _scrambledSentence.add(pengecoh.split(' ').first);
      _scrambledSentence.add(pengecoh.split(' ').last);
    }

    tenseId = tenses.first.id!.oid;
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
      await MiniGameApi().storeScrambledTense(tenseId, _isCorrect);
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
                    builder:
                        (context, AsyncSnapshot<List<GameTense>> snapshot) {
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
                                    return Draggable(
                                      childWhenDragging: TextButton(
                                        onPressed: () =>
                                            _onSelectedLetterDeselected(index),
                                        style: TextButton.styleFrom(
                                          backgroundColor: HexColor(neutral10),
                                          minimumSize: Size(50, 50),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 2,
                                                color: HexColor(colorSuccess)),
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
                                      ),
                                      feedback: TextButton(
                                        onPressed: () =>
                                            _onSelectedLetterDeselected(index),
                                        style: TextButton.styleFrom(
                                          backgroundColor:
                                              HexColor(colorSuccess),
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
                                      ),
                                      child: TextButton(
                                        onPressed: () =>
                                            _onSelectedLetterDeselected(index),
                                        style: TextButton.styleFrom(
                                          backgroundColor:
                                              HexColor(colorSuccess),
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
