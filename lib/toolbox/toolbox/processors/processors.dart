import 'package:shorthand_app/toolbox/core/stroke_direction.dart';
import 'package:shorthand_app/toolbox/model/line.dart';
import 'package:shorthand_app/ui/pages/pigpen_cipher/copy/pigpen_cipher_processor%20copy.dart';

class Processors {
  // Think of this as tool to process sub parts of editor
  // canvas => split by area, group by axis, group by bounding box, group by intersections, check content, hold buffer to check sequential symbols..
  // shortly put ways to organize
  static MainLineTailPoint? containsTriangleWithDot(List<Line> lines) {
    // contains type of lines
    // 1. must have exactly one main polyline and one tail point
    final mainLines = lines.where((line) => line.points.length > 1).toList();
    final tailPoints = lines.where((line) => line.points.length == 1).toList();

    if (mainLines.length != 1 || tailPoints.length != 1) {
      return null; // either no main shape or no tail
    }
    return MainLineTailPoint(mainLines.first, tailPoints.first.points.first);
  }

  static bool containsVerticalCutNCount(Line line, int count) {
    return StrokeCutter.cutByVerticalDirectionChange(line.points).length ==
        count;
  }

  static bool containsHorizontalCutNCount(Line line, int count) {
    return StrokeCutter.cutByHorizontalDirectionChange(line.points).length ==
        count;
  }
}
