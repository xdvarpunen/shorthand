import 'package:shorthand_app/common/toolbox/inspectors/lines_intersection_check.dart';
import 'package:shorthand_app/common/toolbox/toolbox.dart';
import 'package:shorthand_app/engine/point.dart';

class Line2 {
  final List<Point> points;

  Line2(List<Point>? points) : points = points ?? [];
}

extension IntersectionWithLineExtension on Line2 {
  bool intersectWith(Line2 line) {
    return LineIntersectionUtil().linesIntersect(points, line.points);
  }
}

extension LinePropertiesExtension on Line2 {
  Line2? isLineLengthMoreThanOne() {
    if (points.length < 2) return null;
    return this;
  }

  Line2? isLineLengthOne() {
    if (points.length != 1) return null;
    return this;
  }
}

extension LineTypeExtension on Line2 {
  bool isDot() {
    return points.length == 1;
  }

  bool isHorizontal() {
    return Toolbox().inspectors.lineInspector.checkHorizontalLine(points);
  }

  bool isVertical() {
    return Toolbox().inspectors.lineInspector.checkHorizontalLine(points);
  }
}
