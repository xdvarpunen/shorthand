import 'package:flutter/material.dart';
import 'package:shorthand_app/common/model/immutable/canvas_controller.dart';
/// Ogham canvas page
class OghamPage extends StatefulWidget {
  final double locationOfLine;
  final double thicknessOfLine;
  final Color backgroundColor;
  final TextLinesInterpreter? textInterpreter;

  const OghamPage({
    super.key,
    this.locationOfLine = 100,
    this.thicknessOfLine = 32,
    this.backgroundColor = Colors.grey,
    this.textInterpreter,
  });

  @override
  State<OghamPage> createState() => _OghamPageState();
}

class _OghamPageState extends State<OghamPage> {
  late final CanvasController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CanvasController(
      textInterpreter: widget.textInterpreter,
      processOnPointerUp: true,
    );
  }

  void _resetCanvas() {
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ogham Canvas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _resetCanvas,
          ),
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: _controller.undo,
          ),
          IconButton(
            icon: const Icon(Icons.redo),
            onPressed: _controller.redo,
          ),
        ],
      ),
      body: Stack(
        children: [
          OghamPainterWidget(
            controller: _controller,
            locationOfLine: widget.locationOfLine,
            thicknessOfLine: widget.thicknessOfLine,
            backgroundColor: widget.backgroundColor,
          ),
          CanvasGestureLayer(controller: _controller),
        ],
      ),
    );
  }
}

/// Painter + background line
class OghamPainterWidget extends StatelessWidget {
  final CanvasController controller;
  final double locationOfLine;
  final double thicknessOfLine;
  final Color backgroundColor;

  const OghamPainterWidget({
    super.key,
    required this.controller,
    required this.locationOfLine,
    required this.thicknessOfLine,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return CustomPaint(
          painter: _OghamPainter(
            state: controller.state,
            locationOfLine: locationOfLine,
            thicknessOfLine: thicknessOfLine,
            backgroundColor: backgroundColor,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class _OghamPainter extends CustomPainter {
  final CanvasState state;
  final double locationOfLine;
  final double thicknessOfLine;
  final Color backgroundColor;

  _OghamPainter({
    required this.state,
    required this.locationOfLine,
    required this.thicknessOfLine,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Background
    final bgPaint = Paint()..color = backgroundColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // 2. Background line
    final linePaint = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = thicknessOfLine
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(0, locationOfLine),
      Offset(size.width, locationOfLine),
      linePaint,
    );

    // 3. Draw user lines
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (final line in state.model.lines) {
      final points = line.points;
      if (points.isEmpty) continue;

      if (points.length == 1) {
        canvas.drawCircle(Offset(points.first.x, points.first.y), 3.0, paint);
      } else {
        for (int i = 0; i < points.length - 1; i++) {
          final p1 = points[i];
          final p2 = points[i + 1];
          canvas.drawLine(
            Offset(p1.x, p1.y),
            Offset(p2.x, p2.y),
            paint,
          );
        }
      }
    }

    // 4. Draw processor output text
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

  @override
  bool shouldRepaint(covariant _OghamPainter old) => old.state != state;
}
