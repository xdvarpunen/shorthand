
import 'package:flutter/material.dart';
import 'package:shorthand_app/ui/widgets/canvas/canvas_painter.dart';
import 'package:shorthand_app/common/canvas_processor.dart';
import 'package:shorthand_app/engine/line.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';

class BasePaintCanvas extends StatefulWidget {
  final Color backgroundColor;
  final CanvasProcessor? processor;
  final bool showSinglePointCircle;
  final PointsManager? pointsManager;

  const BasePaintCanvas({
    super.key,
    required this.backgroundColor,
    this.processor,
    this.showSinglePointCircle = false,
    this.pointsManager,
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
    _pointsManager = widget.pointsManager ?? PointsManager();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: GestureDetector(
        onPanStart: (details) => _startDrawing(details.localPosition),
        onPanUpdate: (details) => _draw(details.localPosition),
        onPanEnd: (_) => _stopDrawing(),
        child: CustomPaint(
          painter: CanvasPainter(
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