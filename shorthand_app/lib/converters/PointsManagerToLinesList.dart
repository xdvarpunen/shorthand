import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';
import 'package:shorthand_app/soon/minimum_distance_filter.dart';

class Pointsmanagertolineslist {
  List<List<Point>> convert(PointsManager pointsManager) {
    final List<List<Point>> lines = pointsManager.lines
        .map((line) => line.points)
        .toList();
    return lines;
  }

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
