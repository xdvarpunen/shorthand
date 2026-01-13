import 'package:shorthand_app/ui/widgets/canvas/canvas_processor.dart';
import 'package:shorthand_app/engine/line_util.dart';
import 'package:shorthand_app/engine/point.dart';
import 'package:shorthand_app/engine/point_manager.dart';

class Arithmetics extends CanvasProcessor {
  // // neper
  // // sounds like number 9 but reverse
  // bool iPlusSign(List<List<Point>> lines) {
  //   // angle left only
  //   // there top line is above start and end
  //   if (lines.isEmpty) return false;
  //   final line = lines.first;

  //   if (line.length < 2) return false;

  //   return LineUtil().checkHorizontalLine(line);
  // }

  bool isMinusSign(List<List<Point>> lines) {
    // 3 lines
    // one horizontal
    // two vertical intersecting
    if (lines.isEmpty) return false;
    final line = lines.first;

    if (line.length < 2) return false;

    return LineUtil().checkHorizontalLine(line);
  }

  // bool isDivisionSign(List<List<Point>> lines) {
  //   // circle
  //   // vertical crossing twice
  //   // could make alternative where
  //   // right angle only
  //   // intersection between start and end y and x
  //   if (lines.isEmpty) return false;
  //   final line = lines.first;

  //   if (line.length < 2) return false;

  //   return LineUtil().checkHorizontalLine(line);
  // }

  // bool isMultiplicationSign(List<List<Point>> lines) {
  //   // circle
  //   // vertical crossing twice
  //   // could make alternative where
  //   // right angle only
  //   // intersection between start and end y and x
  //   if (lines.isEmpty) return false;
  //   final line = lines.first;

  //   if (line.length < 2) return false;

  //   return LineUtil().checkHorizontalLine(line);
  // }

  String process(List<List<Point>> lines) {
    // if (iPlusSign(lines)) {
    //   return "+";
    // } else if (isMinusSign(lines)) {
    //   return "-";
    // } else if (isDivisionSign(lines)) {
    //   return "/";
    // } else if (isMultiplicationSign(lines)) {
    //   return "*";
    // }
    if (isMinusSign(lines)) {
      return "-";
    }
    return "";
  }

  List<Point> reducePoints(List<Point> points, double minDistance) {
    if (points.isEmpty) return [];

    final reduced = <Point>[points.first];

    for (var i = 1; i < points.length; i++) {
      final last = reduced.last;
      final curr = points[i];

      final dx = (curr.x - last.x).abs();
      final dy = (curr.y - last.y).abs();

      if (dx >= minDistance || dy >= minDistance) {
        reduced.add(curr);
      }
    }

    return reduced;
  }

  @override
  String getOutput(PointsManager pointsManager) {
    final List<List<Point>> lines = pointsManager.lines
        .map(
          (line) => reducePoints(line.points, 3),
        ) // 3, increase... or just use end points only
        .toList();

    final entry = process(lines);
    return 'Char: $entry';
  }
}

class CheckArithmetic {
  String? isMinusSign(List<Point> line) {
    return LineUtil().checkHorizontalLine(line) ? "-" : null;
  }
}
