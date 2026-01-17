import 'package:shorthand_app/common/model/point.dart';

class MinimumDistanceFilter {
  // preprocess for canvas
  bool isBiggerThanMinimumDistance(Point curr, Point last, double minDistance) {
    final dx = (curr.x - last.x).abs();
    final dy = (curr.y - last.y).abs();
    return dx >= minDistance || dy >= minDistance;
  }

  // postprocess for processor
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
}
