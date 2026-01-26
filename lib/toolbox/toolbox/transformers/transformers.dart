import 'package:shorthand_app/toolbox/model/line.dart';
import 'package:shorthand_app/toolbox/model/point.dart';

class Transformers {
  static List<List<Point>> toListOfListOfPoints(List<Line> lines) {
    return lines.map((line) => line.points).toList();
  }
}
