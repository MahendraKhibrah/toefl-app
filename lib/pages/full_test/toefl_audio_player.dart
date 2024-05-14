import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:toefl/utils/utils.dart';

import '../../utils/colors.dart';
import '../../utils/custom_text_style.dart';
import '../../utils/hex_color.dart';
import '../../widgets/blue_container.dart';

class ToeflAudioPlayer extends StatefulWidget {
  const ToeflAudioPlayer({super.key, required this.url});

  final String url;

  @override
  State<ToeflAudioPlayer> createState() => _ToeflAudioPlayerState();
}

class _ToeflAudioPlayerState extends State<ToeflAudioPlayer> {
  final player = AudioPlayer();

  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  void handlePlayPause() {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
  }

  void handleSeek(double val) {
    player.seek(Duration(seconds: val.toInt()));
  }

  void initPlayer() async {
    await player.setUrl(widget.url);

    player.positionStream.listen((event) {
      setState(() {
        position = event;
      });
    });

    player.durationStream.listen((event) {
      setState(() {
        duration = event!;
      });
    });

    player.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        player.pause();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlueContainer(
      innerShadow: true,
      color: mariner200,
      padding: 8.0,
      width: screenWidth * 0.89,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              handlePlayPause();
            },
            child: Icon(
              player.playing ? Icons.pause : Icons.play_arrow_rounded,
              color: HexColor(mariner900),
              size: 35,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(Utils.formatDuration(position), style: CustomTextStyle.normal12),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: screenWidth * 0.6,
            child: Slider(
              value: position.inSeconds.toDouble(),
              min: 0.0,
              max: duration.inSeconds.toDouble(),
              onChanged: (val) {
                handleSeek(val);
              },
              activeColor: HexColor(mariner900),
              inactiveColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
