import 'package:shorthand_app/toolbox/model/point.dart';

class SegmentIntersection {
  /// Returns true if segment p1–p2 intersects segment q1–q2
  static bool intersects(Point p1, Point p2, Point q1, Point q2) {
    final o1 = _orientation(p1, p2, q1);
    final o2 = _orientation(p1, p2, q2);
    final o3 = _orientation(q1, q2, p1);
    final o4 = _orientation(q1, q2, p2);

    return o1 * o2 < 0 && o3 * o4 < 0;
  }

  /// Orientation helper (cross product sign)
  static double _orientation(Point a, Point b, Point c) {
    return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
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
