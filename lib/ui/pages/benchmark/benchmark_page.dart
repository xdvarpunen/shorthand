import 'dart:math' hide Point;
import 'package:flutter/material.dart';
import 'package:shorthand_app/toolbox/model/immutable/canvas_controller.dart';
import 'package:shorthand_app/toolbox/model/line.dart';
import 'package:shorthand_app/toolbox/model/point.dart';
import 'package:shorthand_app/ui/templates/canvas_complex_template_page.dart';
import 'package:shorthand_app/ui/widgets/paint_type_no_processor.dart';

class BenchmarkPage extends StatefulWidget {
  const BenchmarkPage({super.key});

  @override
  State<BenchmarkPage> createState() => _BenchmarkPageState();
}

class _BenchmarkPageState extends State<BenchmarkPage> {
  late final CanvasController _controller;
  final TextLinesInterpreter interpreter = BenchmarkLinesInterpreter();

  @override
  void initState() {
    super.initState();
    _controller = CanvasController(
      textInterpreter: interpreter,
      processOnPointerUp: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CanvasComplexTemplatePage(
      title: 'Benchmark Page',
      controller: _controller,
      onClear: _controller.clear,
      onUndo: _controller.undo,
      onRedo: _controller.redo,
      canvas: PaintTypeNoProcessor(
        backgroundColor: Colors.grey,
        controller: _controller,
      ),
    );
  }
}

class BenchmarkLinesInterpreter extends TextLinesInterpreter {
  int strokeCount(List<Line> lines) => lines.length;
  double totalLength(List<Line> lines) {
    return lines.fold<double>(0.0, (sum, line) => sum + _lineLength(line));
  }

  double getDistanceToPoint(Point point, Point other) {
    final dx = point.x - other.x;
    final dy = point.y - other.y;
    return sqrt(dx * dx + dy * dy);
  }

  double _lineLength(Line line) {
    if (line.points.length < 2) return 0.0;

    double length = 0.0;
    for (var i = 1; i < line.points.length; i++) {
      length += getDistanceToPoint(line.points[i - 1], line.points[i]);
    }
    return length;
  }
  @override
  String process(List<Line> lines) {
    final totalLengthPx = totalLength(lines).round();
    final strokeCnt = strokeCount(lines);
    return 'stroke count: $strokeCnt | total length (px): $totalLengthPx';
  }
}
