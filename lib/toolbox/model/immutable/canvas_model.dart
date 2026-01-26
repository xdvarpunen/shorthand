import 'package:flutter/material.dart';
import 'package:shorthand_app/toolbox/model/line.dart';
import 'package:shorthand_app/toolbox/model/point.dart';

@immutable
class CanvasModel {
  final List<Line> lines;
  final int? activeLineIndex;

  const CanvasModel({
    required this.lines,
    this.activeLineIndex,
  });

  factory CanvasModel.empty() => const CanvasModel(lines: []);

  CanvasModel startLine(Point p) {
    final newLines = [...lines, Line([p])];
    return CanvasModel(
      lines: newLines,
      activeLineIndex: newLines.length - 1,
    );
  }

  CanvasModel addPoint(Point p) {
    if (activeLineIndex == null) return this;

    final updatedLines = List<Line>.from(lines);
    updatedLines[activeLineIndex!] =
        updatedLines[activeLineIndex!].add(p);

    return CanvasModel(
      lines: updatedLines,
      activeLineIndex: activeLineIndex,
    );
  }

  CanvasModel endLine() {
    return CanvasModel(lines: lines);
  }

  CanvasModel clear() => CanvasModel.empty();
}