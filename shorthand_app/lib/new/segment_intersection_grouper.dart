
import 'package:shorthand_app/engine/point.dart';

class SegmentIntersectionGrouper {
  /// Group strokes (list of points) whose line segments intersect
  static List<List<List<Point>>> groupByIntersectingLineSegments(
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
            (g) => _intersectsBySegments(g, other),
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

  static bool _intersectsBySegments(
    List<Point> a,
    List<Point> b,
  ) {
    // Compare all consecutive segments of stroke A vs stroke B
    for (var i = 0; i < a.length - 1; i++) {
      final a1 = a[i];
      final a2 = a[i + 1];

      for (var j = 0; j < b.length - 1; j++) {
        final b1 = b[j];
        final b2 = b[j + 1];

        if (_lineSegmentsIntersect(a1, a2, b1, b2)) {
          return true;
        }
      }
    }

    return false;
  }

  static bool _lineSegmentsIntersect(
    Point p1,
    Point p2,
    Point p3,
    Point p4,
  ) {
    final d1 = _direction(p3, p4, p1);
    final d2 = _direction(p3, p4, p2);
    final d3 = _direction(p1, p2, p3);
    final d4 = _direction(p1, p2, p4);

    if (((d1 > 0 && d2 < 0) || (d1 < 0 && d2 > 0)) &&
        ((d3 > 0 && d4 < 0) || (d3 < 0 && d4 > 0))) {
      return true;
    }

    return false;
  }

  static double _direction(
    Point a,
    Point b,
    Point c,
  ) {
    // Cross product (b - a) x (c - a)
    return (b.x - a.x) * (c.y - a.y) -
        (b.y - a.y) * (c.x - a.x);
  }
}
