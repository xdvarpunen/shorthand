import 'package:shorthand_app/canvas/canvas_processor.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/new/stroke_direction.dart';
import 'package:shorthand_app/new/stroke_util.dart';

class MarsilianaTabletProcessor extends CanvasProcessor {
  bool isC(List<List<Point>> lines) {
    if (lines.isEmpty) return false;

    final line = lines.first;

    final segments = StrokeCutter.cutByHorizontalDirectionChange(line);

    if (segments.length < 2) return false;

    final firstLeft = StrokeInspector.isDirectionRight(segments[0]);
    final secondRight = StrokeInspector.isDirectionLeft(segments[1]);

    return firstLeft && secondRight;
  }

  String process(List<List<Point>> lines) {
    if (isC(lines)) {
      return "C";
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
