  
# Template For Processor

Somewhat the processor is becoming like one below. Use it as quickstart.

````dart
import 'package:shorthand_app/canvas/canvas_processor.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';

class TemplateProcessor extends CanvasProcessor {
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

  String process(List<List<Point>> lines) {
    return "";
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
```
