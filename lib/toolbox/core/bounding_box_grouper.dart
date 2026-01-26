import 'package:shorthand_app/toolbox/model/point.dart';

class BoundingBoxGrouper {
  /// Group strokes (list of points) whose bounding boxes intersect
  static List<List<List<Point>>> groupByIntersectingBoundingBoxes(
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
            (g) => _intersectsByBoundingBox(g, other),
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

  static bool _intersectsByBoundingBox(
    List<Point> a,
    List<Point> b,
  ) {
    final ab = _getBounds(a);
    final bb = _getBounds(b);

    final overlapX = ab.minX <= bb.maxX && ab.maxX >= bb.minX;
    final overlapY = ab.minY <= bb.maxY && ab.maxY >= bb.minY;

    return overlapX && overlapY;
  }

  static _Bounds _getBounds(List<Point> stroke) {
    final minX = stroke.map((p) => p.x).reduce((v, e) => v < e ? v : e);
    final maxX = stroke.map((p) => p.x).reduce((v, e) => v > e ? v : e);
    final minY = stroke.map((p) => p.y).reduce((v, e) => v < e ? v : e);
    final maxY = stroke.map((p) => p.y).reduce((v, e) => v > e ? v : e);

    return _Bounds(minX, minY, maxX, maxY);
  }
}

class _Bounds {
  final double minX;
  final double minY;
  final double maxX;
  final double maxY;

  _Bounds(this.minX, this.minY, this.maxX, this.maxY);
}
