import 'package:shorthand_app/common/canvas_processor.dart';
import 'package:shorthand_app/engine/group_intersecting_lines.dart';
import 'package:shorthand_app/engine/line_intersection_util.dart';
import 'package:shorthand_app/engine/line_util.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';

class TallyMarksFourProcessorService extends CanvasProcessor {
  final LineUtil _lineUtil = LineUtil();
  final LineIntersectionUtil _lineIntersectionUtil = LineIntersectionUtil();

  List<List<Point>> findNonIntersectingVerticalLines(List<List<Point>> lines) {
    List<List<Point>> nonIntersectingVerticalLines = [];

    for (var line in lines) {
      if (_lineUtil.checkVerticalLine(line)) {
        bool intersects = false;
        for (var otherLine in lines) {
          if (line != otherLine &&
              _lineIntersectionUtil.linesIntersect(line, otherLine)) {
            intersects = true;
            break;
          }
        }
        if (!intersects) {
          nonIntersectingVerticalLines.add(line);
        }
      }
    }

    return nonIntersectingVerticalLines;
  }

  int totalCount(List<List<Point>> lines) {
    int count = 0;

    var intersectingLineGrouper = IntersectingLineGrouper();
    var intersectingLines = intersectingLineGrouper.groupIntersectingLines(
      lines,
    );

    for (var index = 0; index < intersectingLines.length; index++) {
      var groupOfIntersectingLines = intersectingLines[index];

      if (groupOfIntersectingLines.length == 1) {
        var verticalLines = groupOfIntersectingLines
            .where((line) => _lineUtil.checkVerticalLine(line))
            .toList();
        if (verticalLines.length == 1) {
          count += 1;
        }
      } else if (groupOfIntersectingLines.length == 2) {
        var horizontalLines = groupOfIntersectingLines
            .where((line) => _lineUtil.checkHorizontalLine(line))
            .toList();
        var verticalLines = groupOfIntersectingLines
            .where((line) => _lineUtil.checkVerticalLine(line))
            .toList();
        if (horizontalLines.length == 1 && verticalLines.length == 1) {
          count += 2;
        }
      } else if (groupOfIntersectingLines.length == 3) {
        var horizontalLines = groupOfIntersectingLines
            .where((line) => _lineUtil.checkHorizontalLine(line))
            .toList();
        var verticalLines = groupOfIntersectingLines
            .where((line) => _lineUtil.checkVerticalLine(line))
            .toList();
        if (horizontalLines.length == 1 && verticalLines.length == 2) {
          count += 3;
        }
      } else if (groupOfIntersectingLines.length == 4) {
        var horizontalLines = groupOfIntersectingLines
            .where((line) => _lineUtil.checkHorizontalLine(line))
            .toList();
        var verticalLines = groupOfIntersectingLines
            .where((line) => _lineUtil.checkVerticalLine(line))
            .toList();
        if (horizontalLines.length == 2 && verticalLines.length == 2) {
          count += 4;
        }
      } else if (groupOfIntersectingLines.length == 5) {
        var horizontalLines = groupOfIntersectingLines
            .where((line) => _lineUtil.checkHorizontalLine(line))
            .toList();
        var verticalLines = groupOfIntersectingLines
            .where((line) => _lineUtil.checkVerticalLine(line))
            .toList();
        if (horizontalLines.length >= 2 && verticalLines.length >= 2) {
          count += 5;
        }
      }
    }

    return count;
  }

  @override
  String getOutput(PointsManager pointsManager) {
    List<List<Point>> lines = pointsManager.lines.map((line) {
      return line.points; // Convert Line objects to Point lists
    }).toList();
    return "Count: ${totalCount(lines)}";
  }
}
