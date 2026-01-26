
import 'package:shorthand_app/toolbox/model/point.dart';

class IntersectingXRangeGrouper {
  /// Check if two strokes intersect along the X-axis (ignore Y)
  static bool intersectsByXRange(
    List<Point> a,
    List<Point> b,
  ) {
    final aMinX = a.map((p) => p.x).reduce((v, e) => v < e ? v : e);
    final aMaxX = a.map((p) => p.x).reduce((v, e) => v > e ? v : e);

    final bMinX = b.map((p) => p.x).reduce((v, e) => v < e ? v : e);
    final bMaxX = b.map((p) => p.x).reduce((v, e) => v > e ? v : e);

    return aMaxX >= bMinX && aMinX <= bMaxX;
  }

  /// Group strokes whose X ranges intersect
  static List<List<List<Point>>> groupByIntersectingXRange(
    List<List<Point>>? strokes,
  ) {
    if (strokes == null || strokes.isEmpty) {
      return <List<List<Point>>>[];
    }

    final groups = <List<List<Point>>>[];
    final visited = <List<Point>>{};

    for (final stroke in strokes) {
      if (visited.contains(stroke)) continue;

      final group = <List<Point>>[stroke];
      visited.add(stroke);

      bool changed;
      do {
        changed = false;

        for (final other in strokes) {
          if (visited.contains(other)) continue;

          final intersects = group.any(
            (g) => intersectsByXRange(g, other),
          );

          if (intersects) {
            group.add(other);
            visited.add(other);
            changed = true;
          }
        }
      } while (changed);

      groups.add(group);
    }

    return groups;
  }
}
