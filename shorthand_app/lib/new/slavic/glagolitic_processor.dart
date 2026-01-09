import 'package:shorthand_app/canvas/canvas_processor.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/new/angle_inspector_final.dart';
import 'package:shorthand_app/new/slavic/idea.dart';

class GlagoliticProcessor extends CanvasProcessor {
  // right left right

  bool isRightLeftRight(List<AngleRun> runs) {
    if (runs.length < 3) return false;

    for (var i = 0; i <= runs.length - 3; i++) {
      if (runs[i].direction == LineDirection.right &&
          runs[i + 1].direction == LineDirection.left &&
          runs[i + 2].direction == LineDirection.right) {
        return true;
      }
    }

    return false;
  }

  bool isD(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    final line = lines.first;

    if (line.length < 2) return false;

    final lineAngle = LineAngle.fromPoints(line);

    final runs = lineAngle.splitByAngleChange();

    return isRightLeftRight(runs);
  }

  bool isLeftRightLeft(List<AngleRun> runs) {
    if (runs.length < 3) return false;

    for (var i = 0; i <= runs.length - 3; i++) {
      if (runs[i].direction == LineDirection.left &&
          runs[i + 1].direction == LineDirection.right &&
          runs[i + 2].direction == LineDirection.left) {
        return true;
      }
    }

    return false;
  }

  bool isB(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    final line = lines.first;

    if (line.length < 2) return false;

    final lineAngle = LineAngle.fromPoints(line);

    final runs = lineAngle.splitByAngleChange();

    return isLeftRightLeft(runs);
  }

  String process(List<List<Point>> lines) {
    if (isD(lines)) {
      return "B Ⰲ";
    } else if (isB(lines)) {
      return "D Ⰴ";
    }
    return "";
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
          (line) => reducePoints(line.points, 3),
        ) // 3, increase... or just use end points only
        .toList();

    final entry = process(lines);
    return 'Char: $entry';
  }
}
