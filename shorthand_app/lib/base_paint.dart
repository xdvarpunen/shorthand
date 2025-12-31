// Base class for all paint types
import 'package:flutter/material.dart';

abstract class BasePaint extends StatelessWidget {
  final Color backgroundColor;

  const BasePaint({super.key, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor, // Set the background color
      child: Center(
        child: CanvasApp(),
      ),
    );
  }
}


class CanvasApp extends StatefulWidget {
  const CanvasApp({super.key});

  @override
  _CanvasAppState createState() => _CanvasAppState();
}

class _CanvasAppState extends State<CanvasApp> {
  List<Offset?> points = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          points.add(details.localPosition);
        });
      },
      onPanEnd: (details) {
        points.add(null); // Adds a separator between strokes
      },
      child: CustomPaint(
        size: Size.infinite,
        painter: CanvasPainter(points),
      ),
    );
  }
}

class CanvasPainter extends CustomPainter {
  final List<Offset?> points;

  CanvasPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    // Draw the points on the canvas (the actual drawing)
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      } else if (points[i] != null && points[i + 1] == null) {
        // Draw point
        canvas.drawCircle(points[i]!, 5.0, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}