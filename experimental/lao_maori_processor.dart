import 'package:shorthand_app/common/canvas_processor.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/engine/angle_inspector_final.dart';
import 'package:shorthand_app/processors/kahakalamahou_processor.dart';

class LaoMaoriProcessor extends CanvasProcessor {
  // 20
  // stacked
  // some letters sequential and combined, can't be more than 2 at the time

  bool isAPart(List<List<Point>> lines) {
    if (lines.isEmpty) return false;

    // Use the first line for now
    final points = lines.first;

    if (points.length < 2) return false;

    final bbox = BoundingBox.fromPoints(points);
    final start = points.first;
    final end = points.last;

    // Condition 1: start and end above bottom of bounding box
    if (start.y >= bbox.maxY || end.y >= bbox.maxY) {
      return false;
    }

    // Condition 2: line only turns left
    final lineAngle = LineAngle.fromPoints(points);

    for (final seg in lineAngle.segments) {
      if (seg.isRight) {
        return false;
      }
    }

    // All checks passed
    return true;
  }

  bool isW(List<List<Point>> lines) {
    if (lines.isEmpty) return false;

    // Use the first line for now
    final points = lines.first;

    if (points.length < 2) return false;

    final bbox = BoundingBox.fromPoints(points);
    final start = points.first;
    final end = points.last;

    if (start.x >= bbox.center.x ||
        end.x >= bbox.center.x && start.y <= end.y) {
      return false;
    }

    // Condition 2: line only turns left
    final lineAngle = LineAngle.fromPoints(points);

    for (final seg in lineAngle.segments) {
      if (seg.isRight) {
        return false;
      }
    }

    // All checks passed
    return true;
  }

  String process(List<List<Point>> lines) {
    return isW(lines) ? "yes" : "no";
  }

  List<Point> reducePoints(List<Point> points, double minDistance) {
    if (points.isEmpty) return [];

    final reduced = <Point>[points.first];

    for (var i = 1; i < points.length; i++) {
      final last = reduced.last;
      final curr = points[i];

      final dx = (curr.x - last.x).abs();
      final dy = (curr.y - last.y).abs();

      if (dx >= minDistance || dy >= minDistance) {
        reduced.add(curr);
      }
    }

    return reduced;
  }

  @override
  String getOutput(PointsManager pointsManager) {
    final List<List<Point>> lines = pointsManager.lines
        .map(
          (line) => reducePoints(line.points, 10),
        ) // 3, increase... or just use end points only
        .toList();

    final entry = process(lines);

    return 'Char: $entry';
  }
}
