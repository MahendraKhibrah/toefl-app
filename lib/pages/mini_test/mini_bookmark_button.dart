import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toefl/models/test/packet_detail.dart';
import 'package:toefl/state_management/mini_test_provider.dart';
import 'package:toefl/utils/colors.dart';

import '../../utils/hex_color.dart';

class MiniBookmarkButton extends ConsumerStatefulWidget {
  const MiniBookmarkButton(
      {super.key, required this.initalValue, required this.questions});

  final int initalValue;
  final List<Question> questions;

  @override
  ConsumerState<MiniBookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends ConsumerState<MiniBookmarkButton> {
  var isActive = false;

  @override
  void initState() {
    super.initState();
    isActive = widget.initalValue >= 1 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            isActive = !isActive;
          });
          EasyDebounce.debounce("bookmark", const Duration(milliseconds: 500),
              () {
            ref
                .read(miniTestProvider.notifier)
                .updateBookmark(widget.questions, isActive ? 1 : 0);
          });
        },
        icon: isActive
            ? Icon(
                Icons.bookmark,
                color: HexColor(mariner700),
                size: 35,
              )
            : const Icon(
                Icons.bookmark_border,
                size: 35,
              ));
  }
}
