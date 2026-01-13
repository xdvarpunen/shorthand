import 'package:flutter/material.dart';
import 'package:shorthand_app/common/canvas_processor.dart';
import 'package:shorthand_app/engine/line.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';

class OghamScriptPaintCanvas extends StatefulWidget {
  final Color backgroundColor;
  final CanvasProcessor? processor;
  final bool showSinglePointCircle;
  final PointsManager pointsManager;
  final double locationOfLine;
  final double thicknessOfLine;

  const OghamScriptPaintCanvas({
    super.key,
    required this.backgroundColor,
    this.processor,
    this.showSinglePointCircle = false,
    required this.pointsManager,
    this.locationOfLine = 100,
    this.thicknessOfLine = 16,
  });

  @override
  OghamScriptPaintCanvasState createState() => OghamScriptPaintCanvasState();
}

class OghamScriptPaintCanvasState extends State<OghamScriptPaintCanvas> {
  Line? _currentLine;

  @override
  void initState() {
    super.initState();
  }

  void _startDrawing(Offset pos) {
    setState(() {
      _currentLine = widget.pointsManager.startLine(Point(pos.dx, pos.dy));
    });
  }

  void _draw(Offset pos) {
    if (_currentLine == null) return;
    setState(() {
      widget.pointsManager.addPoint(_currentLine!, Point(pos.dx, pos.dy));
    });
  }

  void _stopDrawing() => setState(() => _currentLine = null);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: GestureDetector(
        onPanStart: (details) => _startDrawing(details.localPosition),
        onPanUpdate: (details) => _draw(details.localPosition),
        onPanEnd: (_) => _stopDrawing(),
        child: CustomPaint(
          painter: OghamScriptPainter(
            pointsManager: widget.pointsManager,
            processor: widget.processor,
            showSinglePointCircle: widget.showSinglePointCircle,
            locationOfLine: widget.locationOfLine,
            thicknessOfLine: widget.thicknessOfLine
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class OghamScriptPainter extends CustomPainter {
  final PointsManager pointsManager;
  final CanvasProcessor? processor;
  final bool showSinglePointCircle;
  final double locationOfLine;
  final double thicknessOfLine;

  OghamScriptPainter({
    required this.pointsManager,
    required this.processor,
    required this.showSinglePointCircle,
    required this.locationOfLine,
    required this.thicknessOfLine,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    // 1. Draw background line
    _drawBackgroundLine(canvas, size);

    // 2. Draw all lines from PointsManager
    _drawLines(canvas, size, paint);

    // 3. Draw processor output text
    _drawProcessorText(canvas, size);
  }

  // 1. Background line painting
  void _drawBackgroundLine(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = thicknessOfLine;
    canvas.drawLine(Offset(0, locationOfLine), Offset(size.width, locationOfLine), paint);
  }

  // 2. Draw lines from PointsManager
  void _drawLines(Canvas canvas, Size size, Paint paint) {
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
  }

  // 3. Draw the processor's output text
  void _drawProcessorText(Canvas canvas, Size size) {
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
