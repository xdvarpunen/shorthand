import 'package:shorthand_app/canvas/canvas.dart';
import 'package:shorthand_app/engine/group_intersecting_lines.dart';
import 'package:shorthand_app/engine/line_intersection_util.dart';
import 'package:shorthand_app/engine/line_util.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';

class TallyMarksThreeProcessorService extends CanvasProcessor {
  final LineUtil _lineUtil = LineUtil();
  final LineIntersectionUtil _lineIntersectionUtil = LineIntersectionUtil();

  List<List<Point>> findNonIntersectingHorizontalLines(
    List<List<Point>> lines,
  ) {
    List<List<Point>> nonIntersectingHorizontalLines = [];

    for (var line in lines) {
      if (_lineUtil.checkHorizontalLine(line)) {
        bool intersects = false;
        for (var otherLine in lines) {
          if (line != otherLine &&
              _lineIntersectionUtil.linesIntersect(line, otherLine)) {
            intersects = true;
            break;
          }
        }
        if (!intersects) {
          nonIntersectingHorizontalLines.add(line);
        }
      }
    }

    return nonIntersectingHorizontalLines;
  }

  List<Map<String, List<Point>>> findSpecialIntersectingLines(
    List<List<Point>> lines,
  ) {
    List<Map<String, List<Point>>> validPairs = [];

    for (var horizontalLine in lines) {
      if (_lineUtil.checkHorizontalLine(horizontalLine)) {
        List<Point>? intersectingVertical;

        for (var verticalLine in lines) {
          if (_lineUtil.checkVerticalLine(verticalLine) &&
              _lineIntersectionUtil.linesIntersect(
                horizontalLine,
                verticalLine,
              )) {
            if (intersectingVertical != null) {
              intersectingVertical = null;
              break;
            }
            intersectingVertical = verticalLine;
          }
        }

        if (intersectingVertical != null) {
          bool validVertical = true;
          for (var otherHorizontalLine in lines) {
            if (_lineUtil.checkHorizontalLine(otherHorizontalLine) &&
                otherHorizontalLine != horizontalLine) {
              if (_lineIntersectionUtil.linesIntersect(
                intersectingVertical,
                otherHorizontalLine,
              )) {
                validVertical = false;
                break;
              }
            }
          }

          if (validVertical) {
            validPairs.add({
              'horizontal': horizontalLine,
              'vertical': intersectingVertical,
            });
          }
        }
      }
    }

    return validPairs;
  }

  List<List<Point>> findVerticalLinesIntersectingTwoIsolatedHorizontalLines(
    List<List<Point>> lines,
  ) {
    List<List<Point>> validVerticalLines = [];

    for (var verticalLine in lines) {
      if (_lineUtil.checkVerticalLine(verticalLine)) {
        List<List<Point>> intersectingHorizontals = [];

        for (var horizontalLine in lines) {
          if (_lineUtil.checkHorizontalLine(horizontalLine) &&
              _lineIntersectionUtil.linesIntersect(
                verticalLine,
                horizontalLine,
              )) {
            intersectingHorizontals.add(horizontalLine);
          }
        }

        if (intersectingHorizontals.length == 2) {
          bool valid = true;

          for (var horizontalLine in intersectingHorizontals) {
            for (var otherLine in lines) {
              if (_lineUtil.checkHorizontalLine(otherLine) &&
                  otherLine != horizontalLine &&
                  _lineIntersectionUtil.linesIntersect(
                    horizontalLine,
                    otherLine,
                  )) {
                valid = false;
                break;
              }
            }
            if (!valid) break;
          }

          if (valid) {
            validVerticalLines.add(verticalLine);
          }
        }
      }
    }

    return validVerticalLines;
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
