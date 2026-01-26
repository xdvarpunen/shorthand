import 'package:shorthand_app/toolbox/model/point.dart';

class LineIntersectionFinder {
  /// Returns the intersection point of two lines if they intersect, otherwise null.
  /// Each line is represented by a list of points; only first and last points are used as endpoints.
  static Point? findIntersection(List<Point> line1, List<Point> line2) {
    final p1 = line1.first;
    final p2 = line1.last;
    final p3 = line2.first;
    final p4 = line2.last;

    final d1 = direction(p3, p4, p1);
    final d2 = direction(p3, p4, p2);
    final d3 = direction(p1, p2, p3);
    final d4 = direction(p1, p2, p4);

    if (((d1 > 0 && d2 < 0) || (d1 < 0 && d2 > 0)) &&
        ((d3 > 0 && d4 < 0) || (d3 < 0 && d4 > 0))) {
      return _computeIntersectionPoint(p1, p2, p3, p4);
    }

    // Check for special cases where points are colinear and overlap
    if (d1 == 0 && onSegment(p3, p4, p1)) return p1;
    if (d2 == 0 && onSegment(p3, p4, p2)) return p2;
    if (d3 == 0 && onSegment(p1, p2, p3)) return p3;
    if (d4 == 0 && onSegment(p1, p2, p4)) return p4;

    return null;
  }

  /// Helper: Calculate the direction of the point c relative to line segment ab
  static double direction(Point a, Point b, Point c) {
    return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
  }

  /// Helper: Check if point c lies on the segment ab
  static bool onSegment(Point a, Point b, Point c) {
    return (c.x >= a.x && c.x <= b.x || c.x >= b.x && c.x <= a.x) &&
        (c.y >= a.y && c.y <= b.y || c.y >= b.y && c.y <= a.y);
  }

  /// Helper: Compute intersection point of two line segments p1p2 and p3p4
  static Point _computeIntersectionPoint(Point p1, Point p2, Point p3, Point p4) {
    final A1 = p2.y - p1.y;
    final B1 = p1.x - p2.x;
    final C1 = A1 * p1.x + B1 * p1.y;

    final A2 = p4.y - p3.y;
    final B2 = p3.x - p4.x;
    final C2 = A2 * p3.x + B2 * p3.y;

    final det = A1 * B2 - A2 * B1;

    if (det == 0) {
      // Lines are parallel - no single intersection point
      return p1; // fallback: return p1 or null if preferred
    }

    final x = (B2 * C1 - B1 * C2) / det;
    final y = (A1 * C2 - A2 * C1) / det;

    return Point(x, y);
  }
}
