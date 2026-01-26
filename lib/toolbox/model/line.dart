import 'package:flutter/material.dart';
import 'package:shorthand_app/toolbox/model/point.dart';

@immutable
class Line {
  final List<Point> points;

  const Line(this.points);

  Line add(Point p) {
    return Line([...points, p]);
  }
}
