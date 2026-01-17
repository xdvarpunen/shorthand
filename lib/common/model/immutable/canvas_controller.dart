import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shorthand_app/common/model/immutable/canvas_model.dart';
import 'package:shorthand_app/common/model/line.dart';
import 'package:shorthand_app/common/model/point.dart';

/// Generic processor of lines to any output type
abstract class LinesInterpreter<T> {
  /// Transform a list of lines to an output
  T process(List<Line> lines);
}

enum Tool { pen, eraser }

class CanvasController extends ChangeNotifier {
  CanvasModel _model = CanvasModel.empty();
  Tool _tool = Tool.pen;

  String _outputText = '';
  bool processOnPointerUp = false;
  LinesInterpreter<String>? _interpreter;

  final List<CanvasModel> _undoStack = [];
  final List<CanvasModel> _redoStack = [];

  CanvasModel get model => _model;
  Tool get tool => _tool;
  String get outputText => _outputText;

  CanvasController({
    LinesInterpreter<String>? interpreter,
    this.processOnPointerUp = false,
    CanvasModel? initialModel,
    Tool initialTool = Tool.pen,
  }) : _interpreter = interpreter,
       _model = initialModel ?? CanvasModel.empty(),
       _tool = initialTool,
       _outputText = '';

  void _commit(CanvasModel next) {
    _undoStack.add(_model);
    _model = next;
    _redoStack.clear();
    if (!processOnPointerUp) _updateOutput();
    notifyListeners();
  }

  void setInterpreter(LinesInterpreter<String>? interpreter) {
    _interpreter = interpreter;
    if (!processOnPointerUp) _updateOutput();
  }

  // void _updateOutput() {
  //   if (_interpreter == null) return;
  //   _outputText = _interpreter!.process(_model.lines);
  // }
  void _updateOutput() {
    if (_interpreter == null) return;
    _outputText = _interpreter!.process(_model.lines);
    notifyListeners(); // <-- ensure this
  }

  void endLine() {
    // Always commit the final line for undo
    if (_tool == Tool.pen && _model.lines.isNotEmpty) {
      _commit(_model);
    }

    if (processOnPointerUp) {
      _updateOutput();
      notifyListeners();
    }
  }
  // void endLine() {
  //   if (processOnPointerUp) {
  //     _updateOutput(); // process after pointer up
  //     notifyListeners();
  //   }
  // }

  // void endLine() {
  //   if (processOnPointerUp) _updateOutput();
  // }

  CanvasState get state =>
      CanvasState(model: _model, tool: _tool, outputText: _outputText);

  void toggleTool() {
    _tool = _tool == Tool.pen ? Tool.eraser : Tool.pen;
    notifyListeners();
  }

  void startLine(Offset o) {
    if (_tool == Tool.pen) {
      final newLine = Line([Point(o.dx, o.dy)]);
      _commit(CanvasModel(lines: [..._model.lines, newLine]));
    } else {
      eraseLineAt(Point(o.dx, o.dy));
    }
  }

  void addPoint(Offset o) {
    final p = Point(o.dx, o.dy);

    if (_tool == Tool.pen) {
      if (_model.lines.isEmpty) return;
      final lastLine = _model.lines.last;
      final updatedLine = lastLine.add(p);
      final updatedLines = [..._model.lines];
      updatedLines[updatedLines.length - 1] = updatedLine;
      _model = CanvasModel(lines: updatedLines);
      if (!processOnPointerUp) _updateOutput();
      notifyListeners();
    } else if (_tool == Tool.eraser) {
      // Continuous eraser while dragging
      eraseLineAt(p);
    }
  }

  void eraseLineAt(Point p) {
    final updatedLines = _model.lines
        .where((line) => !_isPointOnLine(p, line))
        .toList();
    if (updatedLines.length != _model.lines.length) {
      _commit(CanvasModel(lines: updatedLines));
    }
  }

  // bool _isPointOnLine(Point p, Line line) {
  //   for (int i = 0; i < line.points.length - 1; i++) {
  //     final a = line.points[i];
  //     final b = line.points[i + 1];
  //     if (_distanceToSegment(p, a, b) < 10) return true;
  //   }
  //   return false;
  // }
  bool _isPointOnLine(Point p, Line line) {
    if (line.points.length == 1) {
      return _distance(p, line.points.first) < 10; // radius threshold
    }

    for (int i = 0; i < line.points.length - 1; i++) {
      final a = line.points[i];
      final b = line.points[i + 1];
      if (_distanceToSegment(p, a, b) < 10) return true;
    }
    return false;
  }

  double _distanceToSegment(Point p, Point a, Point b) {
    final dx = b.x - a.x;
    final dy = b.y - a.y;
    if (dx == 0 && dy == 0) return _distance(p, a);
    final t = ((p.x - a.x) * dx + (p.y - a.y) * dy) / (dx * dx + dy * dy);
    if (t < 0) return _distance(p, a);
    if (t > 1) return _distance(p, b);
    return _distance(p, Point(a.x + t * dx, a.y + t * dy));
  }

  double _distance(Point p1, Point p2) {
    final dx = p1.x - p2.x;
    final dy = p1.y - p2.y;
    return sqrt(dx * dx + dy * dy);
  }

  void undo() {
    if (_undoStack.isEmpty) return;
    _redoStack.add(_model);
    _model = _undoStack.removeLast();
    notifyListeners();
  }

  void redo() {
    if (_redoStack.isEmpty) return;
    _undoStack.add(_model);
    _model = _redoStack.removeLast();
    notifyListeners();
  }

  void clear() => _commit(CanvasModel.empty());
}

extension CanvasModelExt on CanvasModel {
  CanvasState toCanvasState(Tool tool, [String outputText = '']) =>
      CanvasState(model: this, tool: tool, outputText: outputText);
}

class CanvasView extends StatelessWidget {
  final CanvasController controller;

  const CanvasView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, _) {
        return RepaintBoundary(
          child: CustomPaint(
            painter: CanvasPainter(
              state: controller.state,
              showSinglePointCircle: true,
            ),
            size: MediaQuery.of(context).size,
          ),
        );
      },
    );
  }
}

class CanvasGestureLayer extends StatelessWidget {
  final CanvasController controller;

  const CanvasGestureLayer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (d) => controller.startLine(d.localPosition),
      onPanUpdate: (d) => controller.addPoint(d.localPosition),
      onPanEnd: (_) => controller.endLine(),
      child: Container(color: Colors.transparent),
    );
  }
}

class DrawingCanvas extends StatelessWidget {
  final CanvasController controller;

  const DrawingCanvas({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CanvasView(controller: controller),
        CanvasGestureLayer(controller: controller),
      ],
    );
  }
}

@immutable
class CanvasState {
  final CanvasModel model;
  final String outputText;
  final Tool tool;

  const CanvasState({
    required this.model,
    this.outputText = '',
    this.tool = Tool.pen,
  });

  CanvasState copyWith({CanvasModel? model, String? outputText, Tool? tool}) =>
      CanvasState(
        model: model ?? this.model,
        outputText: outputText ?? this.outputText,
        tool: tool ?? this.tool,
      );
  factory CanvasState.empty({Tool tool = Tool.pen}) =>
      CanvasState(model: CanvasModel.empty(), tool: tool);
}

class CanvasPainter extends CustomPainter {
  final CanvasState state;
  final bool showSinglePointCircle;

  CanvasPainter({required this.state, required this.showSinglePointCircle});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (final line in state.model.lines) {
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

    if (state.outputText.isNotEmpty) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: state.outputText,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(canvas, Offset(size.width - 120, 20));
    }
  }

  @override
  bool shouldRepaint(covariant CanvasPainter old) {
    return old.state != state ||
        old.showSinglePointCircle != showSinglePointCircle;
  }
}
