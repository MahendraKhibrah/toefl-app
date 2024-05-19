import 'dart:math';

import 'package:flutter/material.dart';
import 'package:toefl/models/game_data.dart';
import 'package:toefl/models/quiz.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/games/game_button.dart';

class GamesLevelPage extends StatelessWidget {
  final int index;
  final List<GameList> quizs;
  final bool isLevelLocked;

  GamesLevelPage(
      {super.key,
      required this.quizs,
      required this.index,
      required this.isLevelLocked});
  final GlobalKey<State<StatefulWidget>> _keyPage = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.biggest.height;
        final width = constraints.biggest.width;
        final List<Offset> pointButtons = [
          Offset(width / 20 * 3, 0),
          Offset(width / 20 * 9, height / 48 * 14),
          Offset(width / 20 * 3, height / 48 * 26),
          Offset(width / 20 * 9, height / 48 * 37.4),
        ];

        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Container(color: Colors.white),
            Positioned.fill(
              child: CustomPaint(
                painter: TestPathPainter(Size(width, height), index),
              ),
            ),
            ...pointButtons.asMap().entries.map((entry) {
              int index = entry.key;
              Offset point = entry.value;
              return Positioned(
                left: point.dx,
                top: point.dy +
                    ((quizs[index].gameClaim!.isEmpty)
                        ? index != 0
                            ? height > 520
                                ? -12
                                : -15
                            : height > 520
                                ? 15
                                : 10
                        : index != 0
                            ? height > 520
                                ? 25
                                : 10
                            : height > 520
                                ? 50
                                : 20),
                child: GameButton(
                  gameList: quizs[index],
                  isLocked: index > 0
                      ? (quizs[index - 1].gameClaim!.isEmpty)
                      : (quizs[index].gameClaim!.isEmpty)
                          ? isLevelLocked
                          : false,
                ),
              );
            }).toList()
          ],
        );
      },
    );
  }
}

class TestPathPainter extends CustomPainter {
  final Size size;
  final int index;
  TestPathPainter(this.size, this.index);
  @override
  void paint(Canvas canvas, Size size) {
    List<Offset> points = <Offset>[];
    debugPrint(size.toString());
    if (index != 0) {
      // points.add(
      //     Offset(size.width / 8 * 5.5, (size.height / 5 * 4.89) - size.height));
      // points
      //     .add(Offset(size.width / 20 * 13, (size.height - 15) - size.height));
      points.add(Offset((size.width / 20 * 13) - 7.5,
          ((size.height / 10 * 8 + 80) - size.height) + 7));
    }
    points.add(Offset(size.width / 20 * 6, size.height / 10 * 2));
    points.add(Offset(size.width / 20 * 13, size.height / 10 * 4 + 30));
    points.add(Offset(size.width / 20 * 6, size.height / 10 * 6 + 55));
    points.add(Offset(size.width / 20 * 13, size.height / 10 * 8 + 80));
    // points.add(Offset(size.width / 20 * 6, (size.height + size.height / 5)));
    points
        .add(Offset(size.width / 20 * 6, size.height + (size.height / 10 * 2)));

    for (var i = 0; i < points.length - 1; i++) {
      var paintLine = Paint()
        ..color = Color(0xff3B73C5)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.bevel
        ..strokeWidth = 20;
      canvas.drawLine(points[i], points[i + 1], paintLine);

      // var paintOval = Paint()
      //   ..color = Colors.blue // Replace with your desired color
      //   ..style = PaintingStyle.fill;
      // canvas.drawOval(
      //   Rect.fromCenter(center: points[i], width: 120, height: 25),
      //   paintOval,
      // );

      // Path path = Path();
      // path.addRRect(
      //   RRect.fromRectAndRadius(
      //     Rect.fromCenter(
      //         center: points[i].translate(0, -15), width: 80, height: 20),
      //     Radius.circular(15),
      //   ),
      // );

      // var paintPath = Paint()
      //   ..color = Colors.grey // Replace with your desired color
      //   ..style = PaintingStyle.fill;
      // canvas.drawPath(path, paintPath);
    }
  }

  @override
  bool shouldRepaint(TestPathPainter oldDelegate) => false;
}

// final random = Random();

// class LinePathPainter extends CustomPainter {
//   final GlobalKey<State<StatefulWidget>> _keyPage;
//   final int index;
//   LinePathPainter(this._keyPage, this.index);
//   @override
//   void paint(Canvas canvas, Size size) {
//     RenderBox box = _keyPage.currentContext!.findRenderObject() as RenderBox;
//     Offset position = box.localToGlobal(Offset.zero);
//     Size size = box.size;
//     print(size.toString());
//     // List<Offset> points = <Offset>[];
//     // for (int i = 0; i < 4; i++) {
//     //   Offset newPos =
//     //       Offset(size.height / 8 * (i % 2 == 1 ? 5 : 2), size.width);
//     //   points.add(newPos);
//     // }

//     if (index != 0) {
//       // points.add(
//       //     Offset(size.width / 8 * 5.5, (size.height / 5 * 4.89) - size.height));
//       points
//           .add(Offset(size.width / 20 * 13, (size.height - 20) - size.height));
//     }
//     points.add(Offset(size.width / 20 * 6, size.height / 10 * 2));
//     points.add(Offset(size.width / 20 * 13, size.height / 10 * 4 + 30));
//     points.add(Offset(size.width / 20 * 6, size.height / 10 * 6 + 55));
//     points.add(Offset(size.width / 20 * 13, size.height / 10 * 8 + 80));
//     points.add(Offset(size.width / 20 * 6, (size.height + size.height / 5)));
//     // points.add(Offset(size.width / 8 * 2, size.height / 5));
//     // Draw lines
//     for (var i = 0; i < points.length - 1; i++) {
//       var paintLine = Paint()
//         ..color = Color(0xff3B73C5)
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 20;
//       canvas.drawLine(points[i], points[i + 1], paintLine);

//       var paintOval = Paint()
//         ..color = Colors.blue // Replace with your desired color
//         ..style = PaintingStyle.fill;
//       canvas.drawOval(
//         Rect.fromCenter(center: points[i], width: 120, height: 25),
//         paintOval,
//       );

//       Path path = Path();
//       path.addRRect(
//         RRect.fromRectAndRadius(
//           Rect.fromCenter(
//               center: points[i].translate(0, -15), width: 80, height: 20),
//           Radius.circular(15),
//         ),
//       );

//       var paintPath = Paint()
//         ..color = Colors.grey // Replace with your desired color
//         ..style = PaintingStyle.fill;
//       canvas.drawPath(path, paintPath);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
