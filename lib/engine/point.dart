import 'dart:math';

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
}

extension PointExtensions on Point {
  // Vertical comparisons
  bool isAbovePoint(Point other) => y > other.y;

  bool isBelowPoint(Point other) => y < other.y;

  // Horizontal comparisons
  bool isRightPoint(Point other) => x > other.x;

  bool isLeftPoint(Point other) => x < other.x;

  // Diagonal comparisons
  bool isAboveRightPoint(Point other) =>
      isAbovePoint(other) && isRightPoint(other);

  bool isBelowRightPoint(Point other) =>
      isBelowPoint(other) && isRightPoint(other);

  bool isAboveLeftPoint(Point other) =>
      isAbovePoint(other) && isLeftPoint(other);

  bool isBelowLeftPoint(Point other) =>
      isBelowPoint(other) && isLeftPoint(other);

  // -------------------
  // Distance methods
  // -------------------

  /// Euclidean (straight-line) distance
  double getDistanceToPoint(Point other) {
    final dx = x - other.x;
    final dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }

  /// True distance comparison
  bool isDistanceToPoint(Point other, double minDistance) {
    return getDistanceToPoint(other) >= minDistance;
  }

  /// Axis-based distance (matches original dx || dy logic)
  bool isAxisDistanceToPoint(Point other, double minDistance) {
    final dx = (x - other.x).abs();
    final dy = (y - other.y).abs();
    return dx >= minDistance || dy >= minDistance;
  }
}
