import 'package:shorthand_app/ui/widgets/canvas/canvas_processor.dart';
import 'package:shorthand_app/engine/line_util.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';

class FordImprovedShorthand extends CanvasProcessor {
  bool isN(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    final line = lines.first;

    if (line.length < 2) return false;

    return LineUtil().checkVerticalLine(line);
  }

  bool isZ2(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    final line = lines.first;

    if (line.length < 2) return false;

    return LineUtil().checkHorizontalLine(line);
  }

  String process(List<List<Point>> lines) {
    if (isN(lines)) {
      return "N";
    } else if (isZ2(lines)) {
      return "Z2";
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
