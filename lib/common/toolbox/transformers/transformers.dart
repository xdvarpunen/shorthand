import 'package:shorthand_app/common/model/line.dart';
import 'package:shorthand_app/engine/point.dart';

class Transformers {
  List<List<Point>> toListOfListOfPoints(List<Line2> lines) {
    return lines.map((line) => line.points).toList();
  }
}
