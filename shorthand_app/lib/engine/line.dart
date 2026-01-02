
import 'package:shorthand_app/engine/point.dart';

class Line {
  final int id;
  final List<Point> points;

  Line({required this.id, List<Point>? points})
      : points = points ?? [];
  void addPoint(Point point) {
    points.add(point);
  }
}