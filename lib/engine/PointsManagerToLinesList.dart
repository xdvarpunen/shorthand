import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/common/toolbox/filters/minimum_distance_filter.dart';

class Pointsmanagertolineslist {
  List<List<Point>> convertWithReducePointsByMinimumDistanceFilter(
    PointsManager pointsManager, {
    double minimumDistance = 3,
  }) {
    final List<List<Point>> lines = pointsManager.lines
        .map(
          (line) => MinimumDistanceFilter().reducePoints(
            line.points,
            minimumDistance,
          ),
        )
        .toList();
    return lines;
  }
}
