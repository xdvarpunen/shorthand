import 'package:shorthand_app/common/core/line_intersection_util.dart';
import 'package:shorthand_app/common/model/point.dart';

class OghamScriptUtil {
  List<Point> upperStemEdge(
    double stemY,
    double thickness, {
    double width = 9999,
  }) {
    final y = stemY - thickness / 2;
    return [Point(0, y), Point(width, y)];
  }

  List<Point> lowerStemEdge(
    double stemY,
    double thickness, {
    double width = 9999,
  }) {
    final y = stemY + thickness / 2;
    return [Point(0, y), Point(width, y)];
  }

  bool lineIntersectWithStem(List<Point> line, List<Point> stem) {
    return LineIntersectionUtil.linesIntersect(line, stem);
  }
}