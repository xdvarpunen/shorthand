import 'package:shorthand_app/canvas/canvas_processor.dart';
import 'package:shorthand_app/converters/PointsManagerToLinesList.dart';
import 'package:shorthand_app/engine/line_util.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';

class MathProcessor extends CanvasProcessor {
  // Vowels
  bool isI(List<List<Point>> lines) {
    if (lines.isEmpty) return false;
    final line = lines.first;

    if (line.length < 2) return false;

    bool isVerticalLine = LineUtil().checkVerticalLine(line);

    return isVerticalLine;
  }

  String process(List<List<Point>> lines) {
    return "";
  }

  @override
  String getOutput(PointsManager pointsManager) {
    final List<List<Point>> lines = Pointsmanagertolineslist()
        .convertWithReducePointsByMinimumDistanceFilter(pointsManager);

    final entry = process(lines);
    // calc
    final calc = 3;
    return 'Math: $entry\nResult:$calc';
  }
}
