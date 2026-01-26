import 'package:shorthand_app/toolbox/model/point.dart';

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

  /// Check if a point is inside the bounding box
  bool contains(Point p) {
    return p.x >= minX && p.x <= maxX && p.y >= minY && p.y <= maxY;
  }
}
