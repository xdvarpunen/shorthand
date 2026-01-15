import 'package:shorthand_app/common/model/line.dart';
import 'package:shorthand_app/common/model/lines.dart';
import 'package:shorthand_app/common/toolbox/toolbox.dart';
import 'package:shorthand_app/engine/point_manager.dart';

abstract class CanvasProcessor {
  String process(Lines2 lines);
  String getOutput(PointsManager pointsManager) {
    Toolbox toolbox = Toolbox();
    final Lines2 lines = Lines2(
      pointsManager.lines
          .map(
            (line) => Line2(
              toolbox.filters.minimumDistanceFilter.reducePoints(
                line.points,
                3,
              ),
            ),
          )
          .toList(),
    );
    return process(lines);
  }
}
