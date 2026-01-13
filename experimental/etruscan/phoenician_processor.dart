import 'package:shorthand_app/ui/widgets/canvas/canvas_processor.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/engine/stroke_direction.dart';
import 'package:shorthand_app/engine/stroke_util.dart';

class PhoenicianProcessor extends CanvasProcessor {
  bool isC(List<List<Point>> lines) {
    if (lines.isEmpty) return false;

    // Use the first line for now
    final line = lines.first;

    // Cut the stroke by horizontal direction changes (left ↔ right)
    final segments = StrokeCutter.cutByHorizontalDirectionChange(line);

    if (segments.length < 4) return false;

    final firstLeft = StrokeInspector.isDirectionLeft(segments[0]);
    final secondRight = StrokeInspector.isDirectionRight(segments[1]);

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
