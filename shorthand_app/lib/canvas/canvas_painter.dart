import 'package:flutter/material.dart';
import 'package:shorthand_app/canvas/canvas_processor.dart';
import 'package:shorthand_app/engine/point_manager.dart';

class CanvasPainter extends CustomPainter {
  final PointsManager pointsManager;
  final CanvasProcessor? processor;
  final bool showSinglePointCircle;

  CanvasPainter({
    required this.pointsManager,
    required this.processor,
    required this.showSinglePointCircle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    // Draw all lines
    for (final line in pointsManager.lines) {
      if (line.points.length == 1) {
        final p1 = line.points[0];
        canvas.drawCircle(Offset(p1.x, p1.y), 5.0, paint);
      } else if (line.points.length > 1) {
        for (int i = 0; i < line.points.length - 1; i++) {
          final p1 = line.points[i];
          final p2 = line.points[i + 1];
          canvas.drawLine(Offset(p1.x, p1.y), Offset(p2.x, p2.y), paint);
        }
      }
    }

    // Draw processor output text
    final outputText = processor?.getOutput(pointsManager);
    final textStyle = TextStyle(color: Colors.black, fontSize: 20);
    final textPainter = TextPainter(
      text: TextSpan(text: outputText, style: textStyle),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width - 120, 20));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}