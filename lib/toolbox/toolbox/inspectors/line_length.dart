

import 'dart:math';

import 'package:shorthand_app/toolbox/model/line.dart';
import 'package:shorthand_app/toolbox/model/point.dart';

class LineLength {
  static double getDistanceToPoint(Point point, Point other) {
    final dx = point.x - other.x;
    final dy = point.y - other.y;
    return sqrt(dx * dx + dy * dy);
  }

  static double lineLength(Line line) {
    if (line.points.length < 2) return 0.0;

    double length = 0.0;
    for (var i = 1; i < line.points.length; i++) {
      length += getDistanceToPoint(line.points[i - 1], line.points[i]);
    }
    return length;
  }
}