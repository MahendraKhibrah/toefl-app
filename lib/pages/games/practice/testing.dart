import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SoalToAudioWidget extends StatefulWidget {
  final String text;
  final double rate;
  final Widget child;

  SoalToAudioWidget({
    required this.text,
    this.rate = 0.7,
    required this.child,
  });

  @override
  _SoalToAudioWidgetState createState() => _SoalToAudioWidgetState();
}

class _SoalToAudioWidgetState extends State<SoalToAudioWidget> {
  late FlutterTts flutterTts;
  TtsState ttsState = TtsState.stopped;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    flutterTts.setStartHandler(() {
      setState(() => ttsState = TtsState.playing);
    });
    flutterTts.setCompletionHandler(() {
      setState(() => ttsState = TtsState.stopped);
    });
    flutterTts.setCancelHandler(() {
      setState(() => ttsState = TtsState.stopped);
    });
  }

  Future<void> _speak() async {
    if (ttsState == TtsState.playing) {
      await flutterTts.stop();
    } else {
      await flutterTts.setSpeechRate(widget.rate);
      await flutterTts.speak(widget.text);
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: _speak,
        child: widget.child);
  }
}

enum TtsState { playing, stopped }
