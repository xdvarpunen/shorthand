import 'package:shorthand_app/canvas/canvas.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/new/stroke_util.dart';

class BoundingBox {
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;

  BoundingBox._(this.minX, this.maxX, this.minY, this.maxY);

  /// Create a bounding box from a list of points
  factory BoundingBox.fromPoints(List<Point> points) {
    if (points.isEmpty) {
      throw ArgumentError('Points list cannot be empty');
    }

    double minX = points.first.x;
    double maxX = points.first.x;
    double minY = points.first.y;
    double maxY = points.first.y;

    for (final p in points) {
      if (p.x < minX) minX = p.x;
      if (p.x > maxX) maxX = p.x;
      if (p.y < minY) minY = p.y;
      if (p.y > maxY) maxY = p.y;
    }

    return BoundingBox._(minX, maxX, minY, maxY);
  }

  /// Center point of the bounding box
  Point get center => Point((minX + maxX) / 2, (minY + maxY) / 2);

  double get width => maxX - minX;
  double get height => maxY - minY;
}

class SegmentIntersection {
  /// Returns true if segment p1–p2 intersects segment q1–q2
  static bool intersects(
    Point p1,
    Point p2,
    Point q1,
    Point q2,
  ) {
    final o1 = _orientation(p1, p2, q1);
    final o2 = _orientation(p1, p2, q2);
    final o3 = _orientation(q1, q2, p1);
    final o4 = _orientation(q1, q2, p2);

    return o1 * o2 < 0 && o3 * o4 < 0;
  }

  /// Orientation helper (cross product sign)
  static double _orientation(Point a, Point b, Point c) {
    return (b.x - a.x) * (c.y - a.y) -
           (b.y - a.y) * (c.x - a.x);
  }
}

class Segment {
  final Point a;
  final Point b;

  Segment(this.a, this.b);

  bool intersects(Segment other) {
    return SegmentIntersection.intersects(a, b, other.a, other.b);
  }
}


class KahakalamahouProcessor extends CanvasProcessor {
  /// Returns true if ANY segment of [points] intersects the segment [s1]–[s2]
  bool polylineIntersectsSegment(List<Point> points, Point s1, Point s2) {
    if (points.length < 2) return false;

    for (int i = 0; i < points.length - 1; i++) {
      final a = points[i];
      final b = points[i + 1];

      if (Segment(a, b).intersects(Segment(s1, s2))) {
        return true;
      }
    }

    return false;
  }

  bool isLa(List<List<Point>> lines) {
    // get bounding box
    // from center to bottom

    // 1. must have exactly one list of points
    if (lines.length != 1 || lines.first.length < 2) {
      return false;
    }

    final points = lines.first;

    // center of bounding box
    final box = BoundingBox.fromPoints(points);

    // 3. vertical line from center to bottom of bounding box
    final rayStart = box.center;
    final rayEnd = Point(box.center.x, box.maxY);

    // 4. check intersection with any segment
    if (polylineIntersectsSegment(points, rayStart, rayEnd)) {
      // crosses the center-to-bottom line → not la
      return false;
    }

    return true;
  }

  bool isNa(List<List<Point>> lines) {
    if (lines.length != 1 || lines.first.length < 2) {
      return false;
    }

    final points = lines.first;

    final box = BoundingBox.fromPoints(points);

    final rayStart = box.center;
    final rayEnd = Point(box.center.x, box.minY);

    if (polylineIntersectsSegment(points, rayStart, rayEnd)) {
      return false;
    }

    return true;
  }

  bool isWa(List<List<Point>> lines) {
    if (lines.length != 1 || lines.first.length < 2) {
      return false;
    }

    final points = lines.first;

    final box = BoundingBox.fromPoints(points);

    final rayStart = box.center;
    final rayEnd = Point(box.minX, box.center.y);

    if (polylineIntersectsSegment(points, rayStart, rayEnd)) {
      return false;
    }

    return true;
  }

  bool isKa(List<List<Point>> lines) {
    if (lines.length != 1 || lines.first.length < 2) {
      return false;
    }

    final points = lines.first;

    final box = BoundingBox.fromPoints(points);

    final rayStart = box.center;
    final rayEnd = Point(box.maxX, box.center.y);

    if (polylineIntersectsSegment(points, rayStart, rayEnd)) {
      return false;
    }

    return true;
  }

  bool isVowelLengthener(List<List<Point>> lines) {
    if (lines.length != 1 || lines.first.length < 2) {
      return false;
    }

    final points = lines.first;

    final isVertical =
        StrokeInspector.getOrientation(points) == StrokeOrientation.vertical;
    return isVertical;
  }

  String process(List<List<Point>> lines) {
    return isVowelLengthener(lines) ? "yes" : "no";
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
