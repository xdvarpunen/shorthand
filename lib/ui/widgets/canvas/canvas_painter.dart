// import 'package:flutter/material.dart';
// import 'package:shorthand_app/ui/widgets/canvas/canvas_state.dart';

// class CanvasPainter extends CustomPainter {
//   final bool showSinglePointCircle;
//   final CanvasState drawState;

//   CanvasPainter({required this.drawState, required this.showSinglePointCircle});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.black
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 5.0;

//     // Draw all lines
//     for (final line in drawState.pointsManager.lines.lines) {
//       if (line.points.length == 1) {
//         final p1 = line.points[0];
//         canvas.drawCircle(Offset(p1.x, p1.y), 5.0, paint);
//       } else if (line.points.length > 1) {
//         for (int i = 0; i < line.points.length - 1; i++) {
//           final p1 = line.points[i];
//           final p2 = line.points[i + 1];
//           canvas.drawLine(Offset(p1.x, p1.y), Offset(p2.x, p2.y), paint);
//         }
//       }
//     }

//     // Draw processor output text
//     if (drawState.outputText.isNotEmpty) {
//       final textStyle = TextStyle(color: Colors.black, fontSize: 20);
//       final textPainter = TextPainter(
//         text: TextSpan(text: drawState.outputText, style: textStyle),
//         textDirection: TextDirection.ltr,
//       );
//       textPainter.layout();
//       textPainter.paint(canvas, Offset(size.width - 120, 20));
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
