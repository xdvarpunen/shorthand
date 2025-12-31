import 'package:flutter/material.dart';
import 'package:shorthand_app/line.dart';
import 'package:shorthand_app/point.dart';
import 'package:shorthand_app/point_manager.dart';
import 'package:shorthand_app/tomtom_code_processor_service.dart';

class CanvasPaintType5 extends StatefulWidget {
  const CanvasPaintType5({super.key});

  @override
  _CanvasPaintType5State createState() => _CanvasPaintType5State();
}

class _CanvasPaintType5State extends State<CanvasPaintType5> {
  late final PointsManager _pointsManager;
  late final TomtomCodeProcessorService _processor;
  Line? _currentLine;

  bool _showSinglePointCircle = true;

  @override
  void initState() {
    super.initState();
    _pointsManager = PointsManager();
    _processor = TomtomCodeProcessorService();
  }

  // Start drawing a new line
  void _startDrawing(Offset pos) {
    setState(() {
      _currentLine = _pointsManager.startLine(Point(pos.dx, pos.dy));
    });
  }

  // Draw the current line by adding points
  void _draw(Offset pos) {
    if (_currentLine == null) return;
    setState(() {
      _pointsManager.addPoint(_currentLine!, Point(pos.dx, pos.dy));
    });
  }

  // Stop drawing when the user lifts their finger
  void _stopDrawing() => setState(() => _currentLine = null);

  // Reset the entire canvas
  // ignore: unused_element
  void _resetCanvas() {
    setState(() => _pointsManager.reset());
  }

  @override
  Widget build(BuildContext context) {
    // Apply background color directly in the Container
    return Container(
      color: Colors.blue,  // Background color applied here
      child: GestureDetector(
        onPanStart: (details) => _startDrawing(details.localPosition),
        onPanUpdate: (details) => _draw(details.localPosition),
        onPanEnd: (_) => _stopDrawing(),
        child: CustomPaint(
          painter: _CanvasPainter(
            pointsManager: _pointsManager,
            showSinglePointCircle: _showSinglePointCircle,
            processorService: _processor,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _CanvasPainter extends CustomPainter {
  final PointsManager pointsManager;
  final bool showSinglePointCircle;
  final TomtomCodeProcessorService processorService;

  _CanvasPainter({
    required this.pointsManager,
    required this.showSinglePointCircle,
    required this.processorService,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    // Draw canvas border
    final borderPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke; // Border only, no fill

    final borderRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(borderRect, borderPaint);

    // Draw all points on the canvas (the actual drawing)
    for (int i = 0; i < pointsManager.lines.length; i++) {
      final line = pointsManager.lines[i];
      for (int j = 0; j < line.points.length - 1; j++) {
        if (line.points[j] != null && line.points[j + 1] != null) {
          canvas.drawLine(
            Offset(line.points[j]!.x, line.points[j]!.y),
            Offset(line.points[j + 1]!.x, line.points[j + 1]!.y),
            paint,
          );
        } else if (line.points[j] != null && line.points[j + 1] == null && showSinglePointCircle) {
          // Draw circle for single point if needed
          canvas.drawCircle(
              Offset(line.points[j]!.x, line.points[j]!.y), 5.0, paint);
        }
      }
    }

    // Additional processing if needed (e.g., displaying count)
    final outputText = processorService.getOutput(pointsManager);
    final textPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final textStyle = TextStyle(color: Colors.black, fontSize: 20);
    final textPainter = TextPainter(
      text: TextSpan(text: outputText, style: textStyle),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width - 120, 20));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
