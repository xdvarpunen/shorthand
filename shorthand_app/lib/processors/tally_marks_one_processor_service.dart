import 'package:shorthand_app/canvas/canvas.dart';
import 'package:shorthand_app/engine/line_intersection_util.dart';
import 'package:shorthand_app/engine/line_util.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';

class TallyMarksOneProcessorService extends CanvasProcessor{
  final LineUtil _lineUtil = LineUtil();
  final LineIntersectionUtil _lineIntersectionUtil = LineIntersectionUtil();

  // Check if horizontal line intersects vertical lines
  bool checkHorizontalLineIntersectsVerticalLines(List<Point> maybeHorizontalLine, List<List<Point>> lines) {
    if (maybeHorizontalLine.isEmpty) {
      throw ArgumentError("Maybe horizontal line should not be null or empty");
    }
    if (lines.isEmpty) {
      throw ArgumentError("Lines should not be null or empty");
    }
    if (_lineUtil.checkHorizontalLine(maybeHorizontalLine)) {
      return intersectsFourVerticalLines(maybeHorizontalLine, lines);
    }
    return false;
  }

  // Check if a horizontal line intersects with four vertical lines
  bool intersectsFourVerticalLines(List<Point> maybeHorizontalLine, List<List<Point>> lines) {
    if (maybeHorizontalLine.isEmpty) {
      throw ArgumentError("Maybe horizontal line should not be null or empty");
    }
    if (lines.isEmpty) {
      throw ArgumentError("Lines should not be null or empty");
    }
    return checkCurrentLineIntersectsLinesCount(maybeHorizontalLine, lines, _lineUtil.checkVerticalLine) == 4;
  }

  // Count how many times the current line intersects with the lines
  int checkCurrentLineIntersectsLinesCount(List<Point> currentLine, List<List<Point>> lines, bool Function(List<Point>) checkIntersectedLine) {
    if (currentLine.isEmpty) {
      throw ArgumentError("Current line should not be null or empty");
    }
    if (lines.isEmpty) {
      throw ArgumentError("Lines should not be null or empty");
    }
    int count = 0;
    for (var line in lines) {
      if (checkCurrentLineIntersectsAnotherLine(currentLine, line)) {
        if (checkIntersectedLine(line)) {
          count += 1;
        }
      }
    }
    return count;
  }

  // Check if the current line intersects with another line
  bool checkCurrentLineIntersectsAnotherLine(List<Point> currentLine, List<Point> anotherLine) {
    if (currentLine.isEmpty) {
      throw ArgumentError("Current line should not be null or empty");
    }
    if (anotherLine.isEmpty) {
      throw ArgumentError("Another line should not be null or empty");
    }
    return _lineIntersectionUtil.linesIntersect(currentLine, anotherLine);
  }


  // Count the total occurrences based on specific conditions
  int totalCount(List<List<Point>> lines) {
    int count = 0;
    count += lines.where((line) => _lineUtil.checkVerticalLine(line)).length;
    count += lines.where((line) => checkHorizontalLineIntersectsVerticalLines(line, lines)).length;
    return count;
  }

  // Get the output based on the PointsManager data
  @override
  String getOutput(PointsManager pointsManager) {
    List<List<Point>> lines = pointsManager.lines.map((line) {
      return line.points;  // Convert Line objects to Point lists
    }).toList();

    return "Count: ${totalCount(lines)}";
  }
}
