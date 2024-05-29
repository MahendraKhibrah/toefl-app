import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';

class WordOfTheDayPage extends StatefulWidget {
  const WordOfTheDayPage({super.key});

  @override
  WordOfTheDayPageState createState() => WordOfTheDayPageState();
}

class WordOfTheDayPageState extends State<WordOfTheDayPage>
    with SingleTickerProviderStateMixin {
  late Map<String, dynamic> flashcard = {};
  int _currentIndex = 0;
  bool _showAnswer = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  List<Map<String, String>> flashcards = [];

  int _getCurrentIndex() {
    final DateTime now = DateTime.now();
    final int seed = int.parse('${now.year}${now.month}${now.day}');
    final Random random = Random(seed);
    return random.nextInt(10000);
  }

  Future<void> getData(int index) async {
    final String response =
        await rootBundle.loadString('assets/json/word.json');
    final List<dynamic> data = json.decode(response);
    final Map<String, dynamic> flashcardData =
        Map<String, dynamic>.from(data[index]);

    setState(() {
      flashcard = flashcardData;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _currentIndex = _getCurrentIndex();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextCard() {
    final int newIndex = (_currentIndex + 1) % 10000;
    getData(newIndex);
    setState(() {
      _currentIndex = newIndex;
    });
  }

  void _toggleAnswer() {
    if (_showAnswer) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      _showAnswer = !_showAnswer;
    });
  }

  void _showFlashcardDialog() {
    getData(_currentIndex);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            child: GestureDetector(
              onTap: _toggleAnswer,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final angle = _animation.value * 3.1415926535897932;
                  final transform = Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(angle);
                  return Transform(
                    transform: transform,
                    alignment: Alignment.center,
                    child: _animation.value <= 0.5
                        ? _buildCard(flashcard['Word'] ?? '', true)
                        : Transform(
                            transform: Matrix4.identity()
                              ..rotateY(3.1415926535897932),
                            alignment: Alignment.center,
                            child:
                                _buildCard(flashcard['Meaning'] ?? '', false),
                          ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: _showFlashcardDialog,
        child: LayoutBuilder(builder: ((context, constraint) {
          return Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: HexColor('#8070F8'),
                ),
                width: constraint.maxHeight / 1,
              ),
              Positioned(
                  bottom: -(constraint.maxHeight / 55),
                  child: SvgPicture.asset(
                    "assets/images/vector_bg_tc1.svg",
                    width: constraint.maxHeight / 1,
                  )),
              Positioned(
                top: (constraint.maxHeight / 18),
                child: Container(
                  width: constraint.maxHeight / 1.8,
                  height: constraint.maxHeight / 1.5,
                  decoration: BoxDecoration(
                    color: HexColor('#BC89FF'),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: constraint.maxHeight / 4.5,
                child: SvgPicture.asset(
                  'assets/images/daily_practice.svg',
                  height: constraint.maxHeight / 3,
                ),
              ),
              Positioned(
                  bottom: constraint.maxHeight / 12,
                  child: Text(
                    'Daily Word',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: constraint.maxHeight / 8,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#BC89FF')),
                  ))
            ],
          );
        })));
  }

  Widget _buildCard(String content, bool isFront) {
    return Card(
      elevation: 4,
      child: Container(
        // width: 300,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: isFront ? HexColor(mariner600) : HexColor(mariner100),
        ),
        height: 350,
        alignment: Alignment.center,
        child: Skeletonizer(
          enabled: true,
          child: Skeleton.leaf(
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: isFront
                  ? GoogleFonts.nunito(
                      fontWeight: FontWeight.w900,
                      fontSize: 50,
                      color: HexColor(mariner50),
                    )
                  : GoogleFonts.nunito(
                      fontSize: 20, color: HexColor(mariner800)),
            ),
          ),
        ),
      ),
    );
  }
}
