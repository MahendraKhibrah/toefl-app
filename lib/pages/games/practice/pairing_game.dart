import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toefl/models/word_synonym.dart';
import 'package:toefl/remote/api/pairing_api.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/quiz/modal/modal_confirmation.dart';

import '../../../widgets/games/game_app_bar.dart';

class PairingGame extends StatefulWidget {
  const PairingGame({super.key});

  @override
  State<PairingGame> createState() => _PairingGameState();
}

class _PairingGameState extends State<PairingGame> {
  List<WordSynonym> words = [];
  List<String> shuffledWords = [];
  List<int> selectedIndices = [];
  List<int> matchedIndices = [];
  List<String> synonymWordIds = [];
  int score = 5;
  String feedbackMessage = '';

  @override
  void initState() {
    super.initState();

    _loadWords();
    print(words);
  }

  void _loadWords() async {
    words = [];
    shuffledWords = [];
    selectedIndices = [];
    matchedIndices = [];
    synonymWordIds = [];
    score = 5;

    String jsonData = await rootBundle.loadString('assets/json/synonym.json');
    final List<dynamic> parsedJson = jsonDecode(jsonData);
    List<WordSynonym> allWords =
        parsedJson.map((json) => WordSynonym.fromJson(json)).toList();
    allWords.shuffle();
    setState(() {
      words = allWords.take(3).toList();
      synonymWordIds = words.map((word) => word.id.oid.toString()).toList();
    });
    _prepareGame();
  }

  void _prepareGame() {
    shuffledWords = [];
    for (var word in words) {
      shuffledWords.add(word.word);
      shuffledWords.add(_getRandomSynonym(word.synonyms));
    }
    shuffledWords.shuffle();
  }

  String _getRandomSynonym(List<String> synonyms) {
    return synonyms[(synonyms.length * _randomDouble()).toInt()];
  }

  double _randomDouble() {
    return DateTime.now().millisecondsSinceEpoch % 10000 / 10000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GameAppBar(
        title: 'Synonym Pairing',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                    child: SvgPicture.asset('assets/images/score.svg'),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.61,
                  top: MediaQuery.of(context).size.height / 10.1,
                  child: SizedBox(
                    width: 38,
                    child: Text('$score',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: HexColor(mariner100))),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                  ),
                  itemCount: shuffledWords.length,
                  itemBuilder: (context, index) {
                    bool isSelected = selectedIndices.contains(index);
                    bool isMatched = matchedIndices.contains(index);

                    return GestureDetector(
                      onTap: () => _onCardTap(index),
                      child: Card(
                        color: isMatched
                            ? HexColor(mariner500)
                            : (isSelected
                                ? HexColor(mariner100)
                                : Colors.white),
                        child: Center(
                          child: Text(
                            shuffledWords[index],
                            style: GoogleFonts.nunito(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: isMatched
                                  ? HexColor(neutral10)
                                  : (isSelected
                                      ? HexColor(mariner700)
                                      : HexColor(mariner500)),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onCardTap(int index) {
    if (matchedIndices.contains(index) || selectedIndices.contains(index)) {
      return;
    }

    setState(() {
      selectedIndices.add(index);
      if (selectedIndices.length == 2) {
        _checkMatch();
      } else if (selectedIndices.length > 2) {
        selectedIndices.removeAt(0);
      }
    });
  }

  void _checkMatch() async {
    int firstIndex = selectedIndices[0];
    int secondIndex = selectedIndices[1];

    String firstWord = shuffledWords[firstIndex];
    String secondWord = shuffledWords[secondIndex];

    bool isMatch = _isPair(firstWord, secondWord);

    if (isMatch) {
      setState(() {
        matchedIndices.addAll(selectedIndices);
      });
    } else {
      setState(() {
        score -= 1;
      });
    }
    if (score <= 0 || matchedIndices.length == 6) {
      bool isSaved = await PairingApi().storeSynonym(synonymWordIds, score);
      if (isSaved) {
        showModalEnd();
      }
      return;
    }
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        selectedIndices.clear();
      });
    });
  }

  bool _isPair(String first, String second) {
    for (var word in words) {
      if ((word.word == first && word.synonyms.contains(second)) ||
          (word.word == second && word.synonyms.contains(first))) {
        return true;
      }
    }
    return false;
  }

  void showModalEnd() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return ModalConfirmation(
          message: "Score $score",
          leftTitle: "Quit",
          rightTitle: "Retry",
          rightFunction: () {
            _loadWords();
            Navigator.pop(context);
          },
          leftFunction: () => Navigator.pushNamedAndRemoveUntil(
            context,
            RouteKey.main,
            (route) => false,
          ),
        );
      },
    );
  }
}
