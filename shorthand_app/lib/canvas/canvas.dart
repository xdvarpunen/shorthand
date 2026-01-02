import 'package:flutter/material.dart';
import 'package:shorthand_app/engine/line.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';

abstract class CanvasProcessor {
  String getOutput(PointsManager pointsManager);
}

class PaintTypeNoProcessor extends StatelessWidget {
  final Color backgroundColor;

  const PaintTypeNoProcessor({super.key, this.backgroundColor = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return BasePaintCanvas(
      backgroundColor: backgroundColor,
      processor: null,
      showSinglePointCircle: false,
    );
  }
}

class BasePaintCanvas extends StatefulWidget {
  final Color backgroundColor;
  final CanvasProcessor? processor;
  final bool showSinglePointCircle;

  const BasePaintCanvas({
    super.key,
    required this.backgroundColor,
    this.processor,
    this.showSinglePointCircle = false,
  });

  @override
  BasePaintCanvasState createState() => BasePaintCanvasState();
}

class BasePaintCanvasState extends State<BasePaintCanvas> {
  late final PointsManager _pointsManager;
  Line? _currentLine;

  @override
  void initState() {
    super.initState();
    _pointsManager = PointsManager();
  }

  void _startDrawing(Offset pos) {
    setState(() {
      _currentLine = _pointsManager.startLine(Point(pos.dx, pos.dy));
    });
  }

  void _draw(Offset pos) {
    if (_currentLine == null) return;
    setState(() {
      _pointsManager.addPoint(_currentLine!, Point(pos.dx, pos.dy));
    });
  }

  void _stopDrawing() => setState(() => _currentLine = null);

  // ignore: unused_element
  void _resetCanvas() => setState(() => _pointsManager.reset());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: GestureDetector(
        onPanStart: (details) => _startDrawing(details.localPosition),
        onPanUpdate: (details) => _draw(details.localPosition),
        onPanEnd: (_) => _stopDrawing(),
        child: CustomPaint(
          painter: _CanvasPainter(
            pointsManager: _pointsManager,
            processor: widget.processor,
            showSinglePointCircle: widget.showSinglePointCircle,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _CanvasPainter extends CustomPainter {
  final PointsManager pointsManager;
  final CanvasProcessor? processor;
  final bool showSinglePointCircle;

  _CanvasPainter({
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
