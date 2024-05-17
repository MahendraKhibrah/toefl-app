// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:toefl/models/game_data.dart';
// import 'package:toefl/models/quiz.dart';
// import 'package:toefl/utils/colors.dart';
// import 'package:toefl/utils/hex_color.dart';
// import 'package:toefl/widgets/games/game_button.dart';

// class GamesLevelPage extends StatelessWidget {
//   final int index;
//   final List<GameList> quizs;

//   GamesLevelPage({super.key, required this.quizs, required this.index});
//   final GlobalKey<State<StatefulWidget>> _keyPage = GlobalKey();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       clipBehavior: Clip.none,
//       key: _keyPage,
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           CustomPaint(
//             painter: LinePathPainter(_keyPage, index),
//           ),
//           // TextButton(
//           //     onPressed: () {
//           //       if (_keyPage.currentContext != null &&
//           //           _keyPage.currentContext!.size != null) {
//           //         print(_keyPage.currentContext!.size!.height.toString());
//           //       }
//           //     },
//           //     child: Text('a')),
//           Container(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Expanded(
//                   child: buildGameButton(context, quizs[0], 1),
//                 ),
//                 Expanded(
//                   child: buildGameButton(context, quizs[1], 2),
//                 ),
//                 Expanded(
//                   child: buildGameButton(context, quizs[2], 3),
//                 ),
//                 Expanded(
//                   child: buildGameButton(context, quizs[3], 4),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildGameButton(BuildContext context, GameList game, int index) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       child: Stack(
//         // alignment: Alignment.centerLeft,
//         children: [
//           Positioned(
//             left: MediaQuery.of(context).size.width /
//                 28 *
//                 (index % 2 == 0 ? 13 : 6),
//             bottom: 10,
//             child: GameButton(
//               quiz: game.quiz,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
//     List<Offset> points = <Offset>[];
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
