import 'package:flutter/material.dart';
import 'package:shorthand_app/toolbox/model/immutable/canvas_controller.dart';
import 'package:shorthand_app/toolbox/model/line.dart';
import 'package:shorthand_app/ui/pages/calligraphy/stroke_segment.dart';
import 'package:shorthand_app/ui/pages/calligraphy/vec2.dart';
import 'package:shorthand_app/ui/pages/calligraphy/vec2converter.dart';

// class CanvasPainter extends CustomPainter {
//   final CanvasState state;
//   final bool showSinglePointCircle;

//   CanvasPainter({required this.state, required this.showSinglePointCircle});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.black
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 5.0;

//     for (final line in state.model.lines) {
//       final points = line.points;

//       if (points.length == 1 && showSinglePointCircle) {
//         final p = points.first;
//         canvas.drawCircle(Offset(p.x, p.y), paint.strokeWidth / 2, paint);
//         continue;
//       }

//       for (int i = 0; i < points.length - 1; i++) {
//         final p1 = points[i];
//         final p2 = points[i + 1];
//         canvas.drawLine(Offset(p1.x, p1.y), Offset(p2.x, p2.y), paint);
//       }
//     }

//     if (state.outputText.isNotEmpty) {
//       final textPainter = TextPainter(
//         text: TextSpan(
//           text: state.outputText,
//           style: const TextStyle(fontSize: 20, color: Colors.black),
//         ),
//         textDirection: TextDirection.ltr,
//       )..layout();

//       textPainter.paint(canvas, Offset(20, 20));
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CanvasPainter old) {
//     return old.state != state ||
//         old.showSinglePointCircle != showSinglePointCircle;
//   }
// }

class CanvasPainter extends CustomPainter {
  final CanvasState state;
  final bool showSinglePointCircle;
  final bool useCalligraphyPen;
  final double calligraphyPenNibAngleDeg;
  final double calligraphyPenNibWidth;

  CanvasPainter({
    required this.state,
    required this.showSinglePointCircle,
    required this.useCalligraphyPen,
    required this.calligraphyPenNibAngleDeg,
    required this.calligraphyPenNibWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!useCalligraphyPen) {
      drawPen(canvas, state.model.lines);
    } else if (useCalligraphyPen) {
      drawCalligraphyPen(canvas, state.model.lines);
    }

    if (state.outputText.isNotEmpty) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: state.outputText,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(canvas, Offset(20, 20));
    }
  }

  void drawPen(Canvas canvas, List<Line> lines) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (final line in lines) {
      final points = line.points;

      if (points.length == 1 && showSinglePointCircle) {
        final p = points.first;
        canvas.drawCircle(Offset(p.x, p.y), paint.strokeWidth / 2, paint);
        continue;
      }

      for (int i = 0; i < points.length - 1; i++) {
        final p1 = points[i];
        final p2 = points[i + 1];
        canvas.drawLine(Offset(p1.x, p1.y), Offset(p2.x, p2.y), paint);
      }
    }
  }

  void drawCalligraphyPen(Canvas canvas, List<Line> lines) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill; // IMPORTANT: fill, not stroke

    // const double nibAngleDeg = 45;
    // const double nibWidth = 20;

    for (final line in lines) {
      final points = line.points;

      if (points.length == 1 && showSinglePointCircle) {
        final p = points.first;
        canvas.drawCircle(Offset(p.x, p.y), calligraphyPenNibWidth / 2, paint);
        continue;
      }

      for (int i = 0; i < points.length - 1; i++) {
        final p1 = points[i];
        final p2 = points[i + 1];
        // canvas.drawLine(Offset(p1.x, p1.y), Offset(p2.x, p2.y), paint);

        final segment = StrokeSegment(
          start: Vec2Converter.fromPoint(p1),
          end: Vec2Converter.fromPoint(p2),
          nibAngleDeg: calligraphyPenNibAngleDeg,
          nibWidth: calligraphyPenNibWidth,
        );

        final polygon = segment.toPolygon(); // List<Point>

        drawPolygon(canvas, paint, polygon);
      }
    }
  }

  void drawPolygon(Canvas canvas, Paint paint, List<Vec2> points) {
    final path = Path()..moveTo(points[0].x, points[0].y);

    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].x, points[i].y);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CanvasPainter old) {
    return old.state != state ||
        old.showSinglePointCircle != showSinglePointCircle;
  }
}
